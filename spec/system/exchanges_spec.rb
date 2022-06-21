require 'rails_helper'

RSpec.describe 'Exchanges management', type: :system do
  let(:exchange) { create(:exchange, name: 'Binance') }

  describe 'create' do
    it do
      visit '/exchanges'

      click_link 'Add exchange'

      fill_in 'Name', with: 'Binance'
      click_button 'Save'

      expect(page).to have_text('Binance')
    end
  end

  describe 'edit' do
    before { exchange }

    it do
      visit '/exchanges'

      click_link(href: edit_exchange_path(exchange))

      fill_in 'Name', with: 'Solana'
      click_button 'Save'

      expect(page).to have_text('Solana')
    end
  end

  describe 'delete' do
    before { exchange }

    it do
      visit '/exchanges'

      page.accept_alert 'Are you sure?' do
        find('i.fa-circle-xmark').find(:xpath, '..').click
      end

      expect(page).not_to have_text('Binance')
    end
  end
end
