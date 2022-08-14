require 'rails_helper'

RSpec.describe 'Tokens management', type: :system do
  let(:token) { create(:token, name: 'Cardano', abbr: 'ADA') }

  describe 'create' do
    it do
      visit '/tokens'

      click_link 'Add token'

      fill_in 'Name', with: token.name
      fill_in 'Abbr', with: token.abbr
      click_button 'Save'

      expect(page).to have_text('ADA')
    end
  end

  describe 'edit' do
    before { token }

    it do
      visit '/tokens'

      click_link(href: edit_token_path(token))

      fill_in 'Name', with: 'Solana'
      fill_in 'Abbr', with: 'SOL'
      click_button 'Save'

      expect(page).to have_text('SOL')
    end
  end

  describe 'delete' do
    before { token }

    it do
      visit '/tokens'

      page.accept_alert 'Are you sure?' do
        find('i.fa-circle-xmark').find(:xpath, '..').click
      end

      expect(page).not_to have_text('ADA')
    end
  end
end
