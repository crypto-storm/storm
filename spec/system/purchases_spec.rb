require 'rails_helper'

RSpec.describe 'Purchases management', type: :system do
  let(:token) { create(:token, name: 'Cardano', abbr: 'ADA') }
  let(:portfolio) { create(:portfolio) }
  let(:location) { create(:chain) }

  let(:purchase) { create(:transaction, :purchase, portfolio:, amount: 100, date: Date.today) }

  let(:transactions) { find('#transactions') }

  describe 'create' do
    before do
      token
      portfolio
      location
    end

    it do
      visit '/transactions'

      click_link 'Add Purchase'

      fill_in '_tx_in_amount', with: 10
      fill_in '_tx_in_rate', with: 5
      click_button 'Save'

      expect(transactions).to have_text('Purchase')
    end
  end

  describe 'edit' do
    before { purchase }

    it do
      visit '/transactions'

      click_link(href: edit_purchase_path(purchase))

      fill_in 'Amount', with: 5
      fill_in 'Rate', with: 10
      click_button 'Save'

      expect(transactions).to have_text('10')
    end
  end

  describe 'delete' do
    before { purchase }

    it do
      visit '/transactions'

      page.accept_alert 'Are you sure?' do
        first('i.fa-circle-xmark').find(:xpath, '..').click
      end

      expect(transactions).not_to have_text('Purchase')
    end
  end
end

