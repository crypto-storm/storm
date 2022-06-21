require 'rails_helper'

RSpec.describe 'Chains management', type: :system do
  let(:chain) { create(:chain, name: 'Cardano') }

  describe 'create' do
    it do
      visit '/chains'

      click_link 'Add chain'

      fill_in 'Name', with: 'Cardano'
      click_button 'Save'

      expect(page).to have_text('Cardano')
    end
  end

  describe 'edit' do
    before { chain }

    it do
      visit '/chains'

      click_link(href: edit_chain_path(chain))

      fill_in 'Name', with: 'Solana'
      click_button 'Save'

      expect(page).to have_text('Solana')
    end
  end

  describe 'delete' do
    before { chain }

    it do
      visit '/chains'

      page.accept_alert 'Are you sure?' do
        find('i.fa-circle-xmark').find(:xpath, '..').click
      end

      expect(page).not_to have_text('Cardano')
    end
  end
end
