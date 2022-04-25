# frozen_string_literal: true

require 'test_helper'

class OnChainTokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @on_chain_token = on_chain_tokens(:one)
  end

  test 'should get index' do
    get on_chain_tokens_url
    assert_response :success
  end

  test 'should get new' do
    get new_on_chain_token_url
    assert_response :success
  end

  test 'should create on_chain_token' do
    assert_difference('OnChainToken.count') do
      post on_chain_tokens_url,
           params: { on_chain_token: { chain_id: @on_chain_token.chain_id, name: @on_chain_token.name,
                                       token_id: @on_chain_token.token_id } }
    end

    assert_redirected_to on_chain_token_url(OnChainToken.last)
  end

  test 'should show on_chain_token' do
    get on_chain_token_url(@on_chain_token)
    assert_response :success
  end

  test 'should get edit' do
    get edit_on_chain_token_url(@on_chain_token)
    assert_response :success
  end

  test 'should update on_chain_token' do
    patch on_chain_token_url(@on_chain_token),
          params: { on_chain_token: { chain_id: @on_chain_token.chain_id, name: @on_chain_token.name,
                                      token_id: @on_chain_token.token_id } }
    assert_redirected_to on_chain_token_url(@on_chain_token)
  end

  test 'should destroy on_chain_token' do
    assert_difference('OnChainToken.count', -1) do
      delete on_chain_token_url(@on_chain_token)
    end

    assert_redirected_to on_chain_tokens_url
  end
end
