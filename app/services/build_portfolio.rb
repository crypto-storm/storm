# frozen_string_literal: true

class BuildPortfolio < ApplicationService
  def initialize(transactions = Transaction.all)
    @transactions = transactions
  end

  def call
    @assets = build_assets
    @assets = inject_prices
    @assets
  end

  private

  def inject_prices(assets = @assets, date = nil)
    assets.map do |asset, amount|
      rates = Token.find(asset).historic_rates.with_rate
      rate = date.nil? ? rates&.last&.rate : rates.find_by(date:)&.rate
      if rate
        total = rate * amount
        [asset, OpenStruct.new(amount:, rate:, total:)]
      else
        [asset, OpenStruct.new(amount:, rate: nil, total: nil)]
      end
    end.to_h
  end

  # rubocop:disable Metrics/AbcSize
  def build_assets(transactions = @transactions)
    assets = Hash.new(0)

    transactions.each do |transaction|
      tx_in = transaction.tx_in
      tx_out = transaction.tx_out

      if transaction.purchase?
        assets[tx_in.token.id] += tx_in.amount
      elsif transaction.sale?
        assets[tx_out.token.id] += tx_out.amount
      elsif transaction.trade?
        assets[tx_in.token.id] += tx_in.amount
        assets[tx_out.token.id] += tx_out.amount
      end
    end

    assets
  end
  # rubocop:enable Metrics/AbcSize
end
