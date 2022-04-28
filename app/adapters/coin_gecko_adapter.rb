# frozen_string_literal: true

class CoinGeckoAdapter
  COIN_GECKO_API_RATE_LIMIT = 50

  def initialize
    @client = CoingeckoRuby::Client.new
    @queue = Limiter::RateQueue.new(COIN_GECKO_API_RATE_LIMIT) do
      Rails.logger.debug 'Hitted rate limit on CoinGecko, sleeping now..'
      sleep 60
    end
  end

  # Proxy every call through method missing
  def method_missing(method, **args)
    @queue.shift
    coin_gecko_token = CoinGeckoToken.find_by(name: args[:token].name.delete(' '))&.slug
    args[:token] = coin_gecko_token
    send("run_#{method}", **args)
  end

  def respond_to_missing?
    true
  end

  def run_historical_price(token:, date:, currency: 'usd')
    response = @client.historical_price(token, date: date_formatter(date))

    retrieve_price(response:, currency:)
  end

  def run_current_price(token:, currency: 'usd')
    response = @client.coin(token)
    retrieve_price(response:, currency:)
  end

  private

  def retrieve_price(response:, currency: 'usd')
    return nil unless response.is_a? Hash

    market_data = response['market_data']
    return nil if market_data.blank?

    current_price = market_data['current_price']
    return nil if current_price.blank?

    current_price[currency]
  end

  def date_formatter(date)
    date.strftime('%d-%m-%Y')
  end
end
