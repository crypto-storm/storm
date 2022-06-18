# frozen_string_literal: true

namespace :coin_gecko do
  task tokens: :environment do
    file = File.read('./lib/scripts/coin_gecko_coins.json')
    data = JSON.parse(file)
    total = data.size
    counter = 0

    data.each do |token|
      symbol = token['symbol']
      slug = token['id']
      name = token['name']
      CoinGeckoToken.create(symbol:, slug:, name:) unless CoinGeckoToken.exists?(slug:)
      p "#{counter}/#{total}: #{symbol}"
      counter += 1
    end
  end
end
