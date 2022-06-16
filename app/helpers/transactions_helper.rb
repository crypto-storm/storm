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

  def format_trading_pair(transaction, type)
    if transaction.trade?
      format_trading_pair_trade(transaction, type)
    elsif transaction.purchase?
      format_trading_pair_purchase(transaction)
    elsif transaction.sale?
      format_trading_pair_sale(transaction)
    end
  end

  def format_rate_transaction(rate, transaction, type)
    rate = if rate.zero? && transaction.purchase?
             return 'GAIN'
           elsif rate.zero? && transaction.sale?
             return 'LOSS'
           else
             format_rate(rate)
           end

    trading_pair = format_trading_pair(transaction, type)
    "#{rate} #{trading_pair}"
  end

  def format_amount(amount)
    if amount.to_i == amount
      amount.to_i
    elsif amount < 1
      amount
    else
      amount.round(3)
    end
  end

  def format_rate(rate)
    if rate.to_i == rate
      rate.to_i
    elsif rate > 0.001
      rate.round(3)
    else
      delimeters = ('1'..'9').to_a
      trailing_zeros = rate.to_s.delete('.').split(Regexp.union(delimeters)).first.size - 1
      rate.round(trailing_zeros + 2)
    end
  end

  private

  def format_trading_pair_purchase(purchase)
    token_in = purchase.tx_in.token.abbr
    "#{token_in}/USD"
  end

  def format_trading_pair_sale(sale)
    token_out = sale.tx_out.token.abbr
    "USD/#{token_out}"
  end

  def format_trading_pair_trade(transaction, type)
    token_out = transaction.tx_out.token.abbr
    token_in = transaction.tx_in.token.abbr

    type == :purchase ? "#{token_out}/#{token_in}" : "#{token_in}/#{token_out}"
  end

  def decimals(value)
    num = 0
    while value != value.to_i
      num += 1
      value *= 10
    end
    num
  end
end
