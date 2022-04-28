# frozen_string_literal: true

class SyncTokenPricesJob < ApplicationJob
  queue_as :default

  def perform
    Token.find_each do |token|
      now = DateTime.now
      current_price = MarketOracle.current_price(token:)
      HistoricRate.create(token:, date: now, rate: current_price)
    end
  end
end
