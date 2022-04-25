# frozen_string_literal: true

require 'application_system_test_case'

class OnChainTokensTest < ApplicationSystemTestCase
  setup do
    @on_chain_token = on_chain_tokens(:one)
  end

  test 'visiting the index' do
    visit on_chain_tokens_url
    assert_selector 'h1', text: 'On chain tokens'
  end

  test 'should create on chain token' do
    visit on_chain_tokens_url
    click_on 'New on chain token'

    fill_in 'Chain', with: @on_chain_token.chain_id
    fill_in 'Name', with: @on_chain_token.name
    fill_in 'Token', with: @on_chain_token.token_id
    click_on 'Create On chain token'

    assert_text 'On chain token was successfully created'
    click_on 'Back'
  end

  test 'should update On chain token' do
    visit on_chain_token_url(@on_chain_token)
    click_on 'Edit this on chain token', match: :first

    fill_in 'Chain', with: @on_chain_token.chain_id
    fill_in 'Name', with: @on_chain_token.name
    fill_in 'Token', with: @on_chain_token.token_id
    click_on 'Update On chain token'

    assert_text 'On chain token was successfully updated'
    click_on 'Back'
  end

  test 'should destroy On chain token' do
    visit on_chain_token_url(@on_chain_token)
    click_on 'Destroy this on chain token', match: :first

    assert_text 'On chain token was successfully destroyed'
  end
end
