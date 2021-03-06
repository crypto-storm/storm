# frozen_string_literal: true

# rubocop:disable Naming/VariableName
# rubocop:disable Lint/UselessAssignment
# rubocop:disable Metrics/ParameterLists

# Destroy current transactions
Transaction.destroy_all

# Portfolios
portfolio = Portfolio.find_by(name: 'Main')

# Exchanges
binance = Exchange.find_by(name: 'Binance')

# Chains
cardano = Chain.find_by(name: 'Cardano')
ethereum = Chain.find_by(name: 'Ethereum')
avalanche = Chain.find_by(name: 'Avalanche')
fantom = Chain.find_by(name: 'Fantom')
harmony = Chain.find_by(name: 'Harmony')
near = Chain.find_by(name: 'NEAR Protocol')
metis = Chain.find_by(name: 'Metis')

# Native tokens
ada = Token.find_by(name: 'Cardano', abbr: 'ADA', native_chain: cardano)
eth = Token.find_by(name: 'Ethereum', abbr: 'ETH', native_chain: ethereum)
avax = Token.find_by(name: 'Avalanche', abbr: 'AVAX', native_chain: avalanche)
ftm = Token.find_by(name: 'Fantom', abbr: 'FTM', native_chain: fantom)
one = Token.find_by(name: 'Harmony', abbr: 'ONE', native_chain: harmony)
metis_token = Token.find_by(name: 'Metis Token', abbr: 'METIS', native_chain: metis)
near_protocol = Token.find_by(name: 'NEAR Protocol', abbr: 'NEAR', native_chain: near)

# ERCs
geist = Token.find_by(name: 'Geist Finance', abbr: 'GEIST')
wsOHM = Token.find_by(name: 'Wrapped Staked Olympus', abbr: 'wsOHM')
jewel = Token.find_by(name: 'DeFi Kingdoms', abbr: 'JEWEL')
usdc = Token.find_by(name: 'USD Coin', abbr: 'USDC')
mim = Token.find_by(name: 'Magic Internet Money', abbr: 'MIM')
dai = Token.find_by(name: 'Dai', abbr: 'DAI')
usdt = Token.find_by(name: 'Tether', abbr: 'USDT')
our = Token.find_by(name: 'Ouranos', abbr: 'OUR')
medal = Token.find_by(name: 'MEDAL', abbr: 'MEDAL')
exc = Token.find_by(name: 'Excalibur', abbr: 'EXC')
boo = Token.find_by(name: 'SpookySwap', abbr: 'BOO')
xBOO = Token.find_by(name: 'Boo MirrorWorld', abbr: 'xBOO')
tshare = Token.find_by(name: 'Tomb Shares', abbr: 'TSHARE')
tomb = Token.find_by(name: 'Tomb', abbr: 'TOMB')
lqdr = Token.find_by(name: 'Liquid Driver', abbr: 'LQDR')
ape = Token.find_by(name: 'ApeCoin', abbr: 'APE')
mai = Token.find_by(name: 'MIMATIC', abbr: 'MAI')
busd = Token.find_by(name: 'Binance USD', abbr: 'BUSD')

# Transactions
def sale(token:, amount:, rate:, date:, portfolio:, location:)
  t = Transaction.new(date:, portfolio:)
  t.build_tx_out(token:, amount:, rate:, location:)
  t.save(validate: false)
end

def purchase(token:, amount:, rate:, date:, portfolio:, location:)
  t = Transaction.new(date:, portfolio:)
  t.build_tx_in(token:, amount:, rate:, location:)
  t.save(validate: false)
end

def trade(t_in:, amount_in:, location_in:, t_out:, amount_out:, date:, portfolio:, location_out:)
  t = Transaction.new(date:, portfolio:)
  t.build_tx_in(token: t_in, amount: amount_in, location: location_in)
  t.build_tx_out(token: t_out, amount: amount_out, location: location_out)
  t.save(validate: false)
end

purchase(token: dai, amount: 109.89, rate: 1, date: '2021-11-09', portfolio:, location: ethereum)
purchase(token: ada, amount: 105.763, rate: 2.27, date: '2021-11-09', portfolio:, location: cardano)
purchase(token: geist, amount: 197.778, rate: 0.6, date: '2021-11-15', portfolio:, location: fantom)
purchase(token: avax, amount: 1.346, rate: 97.98, date: '2021-11-16', portfolio:, location: avalanche)
trade(t_out: avax, amount_out: 1.3, location_out: avalanche, location_in: avalanche, t_in: wsOHM, amount_in: 0.004,
      date: '2021-11-16', portfolio:)
purchase(token: ftm, amount: 58, rate: 2.36, date: '2021-11-23', portfolio:, location: fantom)
purchase(token: ada, amount: 88.87, rate: 1.53, date: '2021-11-26', portfolio:, location: cardano)
purchase(token: ada, amount: 85, rate: 1.26, date: '2021-12-03', portfolio:, location: cardano)
purchase(token: one, amount: 105.75, rate: 0.27, date: '2021-12-10', portfolio:, location: harmony)
trade(t_in: jewel, amount_in: 1, location_in: harmony, location_out: harmony, t_out: one, amount_out: 75,
      date: '2021-12-10', portfolio:)
purchase(token: ftm, amount: 35.9, rate: 2.92, date: '2022-01-05', portfolio:, location: fantom)
purchase(token: usdc, amount: 225, rate: 1, date: '2022-01-05', portfolio:, location: fantom)
purchase(token: avax, amount: 0.715, rate: 90.657, date: '2022-01-16', portfolio:, location: avalanche)
trade(t_in: jewel, amount_in: 1.72488, location_in: avalanche, location_out: avalanche, t_out: avax, amount_out: 0.35,
      date: '2022-01-16', portfolio:)
purchase(token: near, amount: 1.42709, rate: 20.08, date: '2022-01-16', portfolio:, location: near_protocol)
purchase(token: ada, amount: 242.244067, rate: 1.04, date: '2022-01-23', portfolio:, location: cardano)
purchase(token: ftm, amount: 83, rate: 1.93, date: '2022-02-02', portfolio:, location: fantom)
purchase(token: ada, amount: 500, rate: 1.17, date: '2022-02-08', portfolio:, location: cardano)
purchase(token: ftm, amount: 62.11, rate: 1.739, date: '2022-02-21', portfolio:, location: fantom)
purchase(token: ftm, amount: 377.2024, rate: 1.68, date: '2022-02-26', portfolio:, location: fantom)
trade(t_in: mim, amount_in: 275, location_in: fantom, location_out: fantom, t_out: ftm, amount_out: 163.6905,
      date: '2022-02-26', portfolio:)
trade(t_in: dai, amount_in: 175, location_in: fantom, location_out: fantom, t_out: ftm, amount_out: 104.1667,
      date: '2022-02-26', portfolio:)
trade(t_in: usdc, amount_in: 100, location_in: fantom, location_out: fantom, t_out: ftm, amount_out: 59.524,
      date: '2022-02-26', portfolio:)
trade(t_in: usdt, amount_in: 100, location_in: fantom, location_out: fantom, t_out: ftm, amount_out: 59.524,
      date: '2022-02-26', portfolio:)
trade(t_in: ftm, amount_in: 157, location_in: fantom, location_out: fantom, t_out: usdc, amount_out: 220,
      date: '2022-02-18', portfolio:)
trade(t_in: our, amount_in: 295_329.63, location_in: fantom, location_out: fantom, t_out: dai, amount_out: 50,
      date: '2022-02-19', portfolio:)
trade(t_in: ftm, amount_in: 8,  location_in: fantom, location_out: fantom, t_out: dai, amount_out: 10,
      date: '2022-02-20', portfolio:)
trade(t_in: medal, amount_in: 155.60, location_in: fantom, location_out: fantom, t_out: dai, amount_out: 10,
      date: '2022-02-20', portfolio:)
trade(t_in: ftm, amount_in: 9, location_in: fantom, location_out: fantom, t_out: medal, amount_out: 155.60,
      date: '2022-02-23', portfolio:)
trade(t_in: exc, amount_in: 6, location_in: fantom, location_out: fantom, t_out: ftm, amount_out: 10,
      date: '2022-03-03', portfolio:)
trade(t_in: boo, amount_in: 6, location_in: fantom, location_out: fantom, t_out: ftm, amount_out: 63.26,
      date: '2022-03-07', portfolio:)
trade(t_in: xBOO, amount_in: 3.4, location_in: fantom, location_out: fantom, t_out: boo, amount_out: 6,
      date: '2022-03-07', portfolio:)
# I managed to go neutral on geist but trying to align with current stuff I guess
sale(token: geist, amount: 197.778, rate: 0, date: '2022-03-07', portfolio:, location: fantom)
purchase(token: our, amount: 105_000, rate: 0, date: '2022-03-07', portfolio:, location: fantom)
trade(t_out: our, amount_out: 400_329.63, location_out: fantom, location_in: fantom, t_in: ftm, amount_in: 8,
      date: '2022-03-07', portfolio:)
purchase(token: ftm, amount: 6, rate: 0, date: '2022-03-10', portfolio:, location: fantom)
sale(token: usdc, amount: 44, rate: 0, date: '2022-03-15', portfolio:, location: metis)
trade(t_out: exc, amount_out: 6, location_out: fantom, location_in: fantom, t_in: ftm, amount_in: 17.7,
      date: '2022-03-15', portfolio:)
trade(t_in: usdc, amount_in: 275, location_out: fantom, location_in: fantom, t_out: mim, amount_out: 275,
      date: '2022-03-16', portfolio:)
trade(t_in: usdc, amount_in: 143.8, location_out: fantom, location_in: fantom, t_out: dai, amount_out: 143.8,
      date: '2022-03-16', portfolio:)
trade(t_in: usdc, amount_in: 100, location_out: fantom, location_in: fantom, t_out: usdt, amount_out: 100,
      date: '2022-03-16', portfolio:)
purchase(token: tomb, amount: 18.8, rate: 0, date: '2022-03-18', portfolio:, location: fantom)
trade(t_in: mai, amount_in: 42.0706, location_out: fantom, location_in: fantom, t_out: tomb, amount_out: 18.8,
      date: '2022-03-18', portfolio:)
trade(t_in: dai, amount_in: 28.92, location_out: fantom, location_in: fantom, t_out: ftm, amount_out: 20.02,
      date: '2022-03-21', portfolio:)
purchase(token: avax, amount: 1.3958, rate: 74.99, date: '2022-04-12', portfolio:, location: avalanche)
sale(token: avax, amount: 0.31, rate: 0, date: '2022-04-12', portfolio:, location: avalanche)
trade(t_in: ftm, amount_in: 485.18828, location_out: fantom, location_in: fantom, t_out: usdc, amount_out: 579.8,
      date: '2022-04-13', portfolio:)
purchase(token: ftm, amount: 235.147, rate: 1.063, date: '2022-04-23', portfolio:, location: fantom)
trade(t_in: lqdr, amount_in: 25.5, location_out: fantom, location_in: fantom, t_out: ftm, amount_out: 235.147,
      date: '2022-04-23', portfolio:)
purchase(token: ape, amount: 46.16424493, rate: 22.4284, date: '2022-04-29', portfolio:, location: fantom)
trade(t_out: mai, amount_out: 42.0706, location_out: fantom, location_in: fantom, t_in: ftm, amount_in: 49.453774,
      date: '2022-04-30', portfolio:)
trade(t_out: ape, amount_out: 46.16424493, location_out: binance, location_in: binance, t_in: busd, amount_in: 783.13,
      date: '2022-05-01', portfolio:)
trade(t_out: busd, amount_out: 233.28, location_out: binance, location_in: harmony, t_in: one, amount_in: 3000,
      date: '2022-05-01', portfolio:)
trade(t_out: one, amount_out: 2000, location_out: harmony, location_in: harmony, t_in: jewel, amount_in: 98.34,
      date: '2022-05-01', portfolio:)
sale(token: jewel, amount: 90, rate: 0, date: '2022-05-01', portfolio:, location: harmony)
purchase(token: jewel, amount: 72, rate: 0, date: '2022-05-07', portfolio:, location: harmony)
trade(t_out: busd, amount_out: 76, location_out: binance, location_in: harmony, t_in: one, amount_in: 999,
      date: '2022-05-07', portfolio:)

# rubocop:enable Metrics/ParameterLists
# rubocop:enable Naming/VariableName
# rubocop:enable Lint/UselessAssignment
