# frozen_string_literal: true

COIN_GECKO_API_RATE_LIMIT = 50

def date_formatter(date)
  date.strftime('%d-%m-%Y')
end

def price_on_date(client, token, date)
  response = client.historical_price(token, date: date_formatter(date))

  market_data = response['market_data']
  return if market_data.nil?

  current_price = market_data['current_price']
  return if current_price.nil?

  current_price['usd']
end

# rubocop:disable Metrics/BlockLength
namespace :historic_rate do
  desc 'Builds the historic rates from CoinGecko for every token being currently track. Isomorphic.'
  task build: :environment do
    queue = Limiter::RateQueue.new(COIN_GECKO_API_RATE_LIMIT) do
      puts 'Hitted rate limit on CoinGecko, sleeping now..'
      sleep 60
    end
    client = CoingeckoRuby::Client.new
    initial_date = Time.zone.today - 5.years
    final_date = Time.zone.today
    dates = (initial_date..final_date).to_a.reverse

    Token.find_each do |token|
      puts "Loading data for #{token.name}"
      dates.each do |date|
        next if token.historic_rates.exists?(date:)

        coin_gecko_token = CoinGeckoToken.find_by(name: token.name.delete(' '))&.slug
        coin_gecko_token ||= CoinGeckoToken.find_by(name: token.name)&.slug
        coin_gecko_token ||= CoinGeckoToken.find_by(symbol: token.abbr.downcase)&.slug

        if coin_gecko_token
          queue.shift

          rate = price_on_date(client, coin_gecko_token, date)
          break if rate.nil?

          HistoricRate.create(token:, date:, rate:)

          puts "#{token.name} costed #{rate} at #{date}"
        else
          puts "Skipped #{token.name} because it doesn't exist on coingecko."
          break
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
