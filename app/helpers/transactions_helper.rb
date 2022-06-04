# frozen_string_literal: true

module TransactionsHelper
  def edit_transaction_path_helper(transaction)
    if transaction.trade?
      edit_transaction_path(transaction)
    elsif transaction.purchase?
      edit_purchase_path(transaction)
    elsif transaction.sale?
      edit_sale_path(transaction)
    end
  end
end
