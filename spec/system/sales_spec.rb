require 'rails_helper'

RSpec.describe 'Sales management', type: :system do
  let(:token) { create(:token, name: 'Cardano', abbr: 'ADA') }
  let(:portfolio) { create(:portfolio) }

  let(:purchase) { create(:transaction, :purchase, token:, portfolio:, amount: 1000, date: Date.today - 1.day) }
  let(:sale) { create(:transaction, :sale, token:, portfolio:, amount: 100, date: Date.today) }

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

      click_link 'Add Sale'

      fill_in '_tx_out_amount', with: 10
      fill_in '_tx_out_rate', with: 5
      click_button 'Save'

      expect(transactions).to have_text('Sale')
    end
  end

  describe 'edit' do
    before do
      purchase
      PortfolioOverviews.refresh
      sale
    end

    it do
      visit '/transactions'

      click_link(href: edit_sale_path(sale))

      fill_in 'Amount', with: 5
      fill_in 'Rate', with: 10
      click_button 'Save'

      expect(transactions).to have_text('10')
    end
  end

  describe 'delete' do
    before do
      purchase
      PortfolioOverviews.refresh
      sale
    end

    it do
      visit '/transactions'

      page.accept_alert 'Are you sure?' do
        first('i.fa-circle-xmark').find(:xpath, '..').click
      end

      expect(transactions).not_to have_text('Sale')
    end
  end
end
