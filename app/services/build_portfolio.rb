# frozen_string_literal: true

class BuildPortfolio < ApplicationService
  def initialize(transactions = Transaction.all)
    @transactions = transactions
  end

  def call
    @assets = build_assets
    @assets = inject_prices
    OpenStruct.new(assets: @assets, evolution: build_evolution)
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
        assets[tx_out.token.id] -= tx_out.amount
      elsif transaction.trade?
        assets[tx_in.token.id] += tx_in.amount
        assets[tx_out.token.id] -= tx_out.amount
      end
    end

    assets
  end

  def build_evolution
    evolution = Hash.new(0)
    today = Time.zone.today
    year_ago = today - 1.year

    (year_ago..today).step(1.month.in_days.to_i).each do |date|
      transactions = @transactions.in_interval(year_ago, date)
      assets = build_assets(transactions)
      evolution[date] = inject_prices(assets, date).values.reduce(0) do |acc, data|
        data.total ? acc + data.total : acc
      end.to_f
    end

    evolution
  end
  # rubocop:enable Metrics/AbcSize
end
