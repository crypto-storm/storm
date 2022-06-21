require 'rails_helper'

RSpec.describe 'Trades management', type: :system do
  let(:token) { create(:token, name: 'Cardano', abbr: 'ADA') }
  let(:token_in) { create(:token, name: 'Fantom', abbr: 'FTM') }
  let(:portfolio) { create(:portfolio) }

  let(:purchase) { create(:transaction, :purchase, token:, portfolio:, amount: 1000, date: Date.today - 1.day) }
  let(:trade) { create(:transaction, :trade, token_in:, token_out: token, portfolio:, date: Date.today) }

  let(:transactions) { find('#transactions') }

  describe 'on index' do
    before { purchase }

    it 'there is a purchase' do
      visit '/transactions'

      expect(transactions).to have_text('Purchase')
    end
  end

  describe 'create' do
    before do
      purchase
      PortfolioOverviews.refresh
    end

    it do
      visit '/transactions'

      click_link 'Add Trade'

      fill_in 'transaction_tx_out_amount', with: 10
      fill_in 'transaction_tx_in_amount', with: 10
      click_button 'Save'

      expect(transactions).to have_text('Trade')
    end
  end

  describe 'edit' do
    before do
      purchase
      PortfolioOverviews.refresh
      trade
    end

    it do
      visit '/transactions'

      click_link(href: edit_transaction_path(trade))

      fill_in 'transaction_tx_out_amount', with: 5
      fill_in 'transaction_tx_in_amount', with: 5
      click_button 'Save'

      expect(transactions).to have_text('5')
    end
  end

  describe 'delete' do
    before do
      purchase
      PortfolioOverviews.refresh
      trade
    end

    it do
      visit '/transactions'

      page.accept_alert 'Are you sure?' do
        first('i.fa-circle-xmark').find(:xpath, '..').click
      end

      expect(transactions).not_to have_text('Trade')
    end
  end
end
