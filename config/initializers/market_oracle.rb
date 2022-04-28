# frozen_string_literal: true

require 'coin_gecko_adapter'

class MarketData
  def initialize
    @coin_gecko = CoinGeckoAdapter.new
  end

  def historical_price(token:, date:, adapter: @coin_gecko)
    adapter.historical_price(token:, date:)
  end

  def current_price(token:, adapter: @coin_gecko)
    adapter.current_price(token:)
  end
end

MarketOracle = MarketData.new
