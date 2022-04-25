# frozen_string_literal: true

class BuildPortfolio < ApplicationService
  def initialize(transactions = Transaction.all)
    @transactions = transactions
  end

  # rubocop:disable Metrics/AbcSize
  def call
    assets = Hash.new(0)

    @transactions.each do |transaction|
      tx_in = transaction.tx_in
      tx_out = transaction.tx_out

      if transaction.purchase?
        assets[tx_in.token.id] += tx_in.amount
      elsif transaction.sale?
        assets[tx_out.token.id] -= tx_out.amount
      elsif transaction.trade?
        assets[tx_in.token.id] += tx_in.amount
        assets[tx_out.token.id] -= tx_out.amount
      end
    end

    assets
  end
  # rubocop:enable Metrics/AbcSize
end
