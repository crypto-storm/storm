# frozen_string_literal: true

require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @location = chains(:one)
    @tx_in = transaction_data(:one)
    @tx_in.location = @location
    @tx_out = transaction_data(:two)
    @tx_out.location = @location
    @transaction = transactions(:one)
    @transaction.tx_in = @tx_in
    @transaction.tx_out = @tx_out
  end

  test 'should get index' do
    get transactions_url
    assert_response :success
  end

  test 'should get new' do
    get new_transaction_url
    assert_response :success
  end

  # TODO: Rebuild this when using factories
  test 'should create transaction' do
    # assert_difference('Transaction.count') do
    # post transactions_url,
    # params: { transaction:
    # {
    # tx_in: { token_id: @tx_in.id, amount: @tx_in.amount },
    # tx_out: { token_id: @tx_out.id, amount: @tx_out.amount }
    # } }
    # end

    # assert_redirected_to transaction_url(Transaction.last)
  end

  test 'should get edit' do
    get edit_transaction_url(@transaction)
    assert_response :success
  end

  # TODO: Rebuild this when using factories
  test 'should update transaction' do
    # patch transaction_url(@transaction),
    # params: { transaction:
    # {
    # tx_in: { token_id: @tx_in.id, amount: @tx_in.amount },
    # tx_out: { token_id: @tx_out.id, amount: @tx_out.amount }
    # } }
    # assert_redirected_to transaction_url(@transaction)
  end

  test 'should destroy transaction' do
    assert_difference('Transaction.count', -1) do
      delete transaction_url(@transaction)
    end

    assert_redirected_to transactions_url
  end
end
