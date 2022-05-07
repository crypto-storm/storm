# frozen_string_literal: true

# rubocop:disable Naming/VariableName
# rubocop:disable Metrics/ParameterLists

def set_logo(object, filename)
  path = Rails.root.join('app/assets/images/')
  object.logo.attach(io: File.open(path.join(filename)), filename:)
  object.save
end

# Portfolios
portfolio = Portfolio.create(name: 'Main')

# Chains
cardano = Chain.new(name: 'Cardano')
set_logo(cardano, 'cardano.jpg')

ethereum = Chain.new(name: 'Ethereum')
set_logo(ethereum, 'eth.png')

avalanche = Chain.new(name: 'Avalanche')
set_logo(avalanche, 'avax.png')

fantom = Chain.new(name: 'Fantom')
set_logo(fantom, 'fantom.png')

harmony = Chain.new(name: 'Harmony')
set_logo(harmony, 'one.png')

near = Chain.new(name: 'NEAR Protocol')
set_logo(near, 'near.jpeg')

Rails.logger.debug 'Built chains!'

# Native tokens
ada = Token.new(name: 'Cardano', abbr: 'ADA', native_chain: cardano)
set_logo(ada, 'cardano.jpg')

eth = Token.new(name: 'Ethereum', abbr: 'ETH', native_chain: ethereum)
set_logo(eth, 'eth.png')

avax = Token.new(name: 'Avalanche', abbr: 'AVAX', native_chain: avalanche)
set_logo(avax, 'avax.png')

ftm = Token.new(name: 'Fantom', abbr: 'FTM', native_chain: fantom)
set_logo(ftm, 'fantom.png')

one = Token.new(name: 'Harmony', abbr: 'ONE', native_chain: harmony)
set_logo(one, 'one.png')

near = Token.new(name: 'NEAR Protocol', abbr: 'NEAR', native_chain: near)
set_logo(near, 'near.jpeg')

Rails.logger.debug 'Built tokens!'

# ERCs
geist = Token.new(name: 'Geist Finance', abbr: 'GEIST')
set_logo(geist, 'geist.png')

wsOHM = Token.new(name: 'Wrapped Staked Olympus', abbr: 'wsOHM')
set_logo(wsOHM, 'wsOHM.png')

jewel = Token.new(name: 'DeFi Kingdoms', abbr: 'JEWEL')
set_logo(jewel, 'jewel.png')

usdc = Token.new(name: 'USD Coin', abbr: 'USDC')
set_logo(usdc, 'usdc.png')

mim = Token.new(name: 'Magic Internet Money', abbr: 'MIM')
set_logo(mim, 'mim.png')

dai = Token.new(name: 'Dai', abbr: 'DAI')
set_logo(dai, 'dai.png')

usdt = Token.new(name: 'Tether', abbr: 'USDT')
set_logo(usdt, 'usdt.png')

our = Token.new(name: 'Ouranos', abbr: 'OUR')
set_logo(our, 'our.png')

medal = Token.new(name: 'MEDAL', abbr: 'MEDAL')
set_logo(medal, 'medal.png')

exc = Token.new(name: 'Excalibur', abbr: 'EXC')
set_logo(exc, 'exc.png')

boo = Token.new(name: 'SpookySwap', abbr: 'BOO')
set_logo(boo, 'boo.png')

xBOO = Token.new(name: 'Boo MirrorWorld', abbr: 'xBOO')
set_logo(xBOO, 'xBOO.webp')

tshare = Token.new(name: 'Tomb Shares', abbr: 'TSHARE')
set_logo(tshare, 'tshare.png')

tomb = Token.new(name: 'Tomb', abbr: 'TOMB')
set_logo(tomb, 'tomb.png')

lqdr = Token.new(name: 'Liquid Driver', abbr: 'LQDR')
set_logo(lqdr, 'lqdr.png')

ape = Token.new(name: 'ApeCoin', abbr: 'APE')
set_logo(ape, 'ape.png')

mai = Token.new(name: 'MIMATIC', abbr: 'MAI')
set_logo(mai, 'mai.webp')

busd = Token.new(name: 'Binance USD', abbr: 'BUSD')
set_logo(busd, 'busd.png')

Rails.logger.debug 'Built ERCs!'

# Transactions
def sale(token:, amount:, rate:, date:, portfolio:)
  t = Transaction.new(date:, portfolio:)
  t.build_tx_out(token:, amount:, rate:)
  t.save(validate: false)
end

def purchase(token:, amount:, rate:, date:, portfolio:)
  t = Transaction.new(date:, portfolio:)
  t.build_tx_in(token:, amount:, rate:)
  t.save(validate: false)
end

def trade(t_in:, amount_in:, t_out:, amount_out:, date:, portfolio:)
  t = Transaction.new(date:, portfolio:)
  t.build_tx_in(token: t_in, amount: amount_in)
  t.build_tx_out(token: t_out, amount: amount_out)
  t.save(validate: false)
end

purchase(token: dai, amount: 109.89, rate: 1, date: '2021-11-09', portfolio:)
purchase(token: ada, amount: 105.763, rate: 2.27, date: '2021-11-09', portfolio:)
purchase(token: geist, amount: 197.778, rate: 0.6, date: '2021-11-15', portfolio:)
purchase(token: avax, amount: 1.346, rate: 97.98, date: '2021-11-16', portfolio:)
trade(t_out: avax, amount_out: 1.3, t_in: wsOHM, amount_in: 0.004, date: '2021-11-16', portfolio:)
purchase(token: ftm, amount: 58, rate: 2.36, date: '2021-11-23', portfolio:)
purchase(token: ada, amount: 88.87, rate: 1.53, date: '2021-11-26', portfolio:)
purchase(token: ada, amount: 85, rate: 1.26, date: '2021-12-03', portfolio:)
purchase(token: one, amount: 105.75, rate: 0.27, date: '2021-12-10', portfolio:)
trade(t_in: jewel, amount_in: 1, t_out: one, amount_out: 75, date: '2021-12-10', portfolio:)
purchase(token: ftm, amount: 35.9, rate: 2.92, date: '2022-01-05', portfolio:)
purchase(token: usdc, amount: 225, rate: 1, date: '2022-01-05', portfolio:)
purchase(token: avax, amount: 0.715, rate: 90.657, date: '2022-01-16', portfolio:)
trade(t_in: jewel, amount_in: 1.72488, t_out: avax, amount_out: 0.35, date: '2022-01-16', portfolio:)
purchase(token: near, amount: 1.42709, rate: 20.08, date: '2022-01-16', portfolio:)
purchase(token: ada, amount: 242.244067, rate: 1.04, date: '2022-01-23', portfolio:)
purchase(token: ftm, amount: 83, rate: 1.93, date: '2022-02-02', portfolio:)
purchase(token: ada, amount: 500, rate: 1.17, date: '2022-02-08', portfolio:)
purchase(token: ftm, amount: 62.11, rate: 1.739, date: '2022-02-21', portfolio:)
purchase(token: ftm, amount: 377.2024, rate: 1.68, date: '2022-02-26', portfolio:)
trade(t_in: mim, amount_in: 275, t_out: ftm, amount_out: 163.6905, date: '2022-02-26', portfolio:)
trade(t_in: dai, amount_in: 175, t_out: ftm, amount_out: 104.1667, date: '2022-02-26', portfolio:)
trade(t_in: usdc, amount_in: 100, t_out: ftm, amount_out: 59.524, date: '2022-02-26', portfolio:)
trade(t_in: usdt, amount_in: 100, t_out: ftm, amount_out: 59.524, date: '2022-02-26', portfolio:)
trade(t_in: ftm, amount_in: 157, t_out: usdc, amount_out: 220, date: '2022-02-18', portfolio:)
trade(t_in: our, amount_in: 295_329.63, t_out: dai, amount_out: 50, date: '2022-02-19', portfolio:)
trade(t_in: ftm, amount_in: 8, t_out: dai, amount_out: 10, date: '2022-02-20', portfolio:)
trade(t_in: medal, amount_in: 155.60, t_out: dai, amount_out: 10, date: '2022-02-20', portfolio:)
trade(t_in: ftm, amount_in: 9, t_out: medal, amount_out: 155.60, date: '2022-02-23', portfolio:)
trade(t_in: exc, amount_in: 6, t_out: ftm, amount_out: 10, date: '2022-03-03', portfolio:)
trade(t_in: boo, amount_in: 6, t_out: ftm, amount_out: 63.26, date: '2022-03-07', portfolio:)
trade(t_in: xBOO, amount_in: 3.4, t_out: boo, amount_out: 6, date: '2022-03-07', portfolio:)
# I managed to go neutral on geist but trying to align with current stuff I guess
sale(token: geist, amount: 197.778, rate: 0, date: '2022-03-07', portfolio:)
purchase(token: our, amount: 105_000, rate: 0, date: '2022-03-07', portfolio:)
trade(t_out: our, amount_out: 400_329.63, t_in: ftm, amount_in: 8, date: '2022-03-07', portfolio:)
purchase(token: ftm, amount: 6, rate: 0, date: '2022-03-10', portfolio:)
sale(token: usdc, amount: 44, rate: 0, date: '2022-03-15', portfolio:)
trade(t_out: exc, amount_out: 6, t_in: ftm, amount_in: 17.7, date: '2022-03-15', portfolio:)
trade(t_in: usdc, amount_in: 275, t_out: mim, amount_out: 275, date: '2022-03-16', portfolio:)
trade(t_in: usdc, amount_in: 143.8, t_out: dai, amount_out: 143.8, date: '2022-03-16', portfolio:)
trade(t_in: usdc, amount_in: 100, t_out: usdt, amount_out: 100, date: '2022-03-16', portfolio:)
purchase(token: tomb, amount: 18.8, rate: 0, date: '2022-03-18', portfolio:)
trade(t_in: mai, amount_in: 42.0706, t_out: tomb, amount_out: 18.8, date: '2022-03-18', portfolio:)
trade(t_in: dai, amount_in: 28.92, t_out: ftm, amount_out: 20.02, date: '2022-03-21', portfolio:)
purchase(token: avax, amount: 1.3958, rate: 74.99, date: '2022-04-12', portfolio:)
sale(token: avax, amount: 0.31, rate: 0, date: '2022-04-12', portfolio:)
trade(t_in: ftm, amount_in: 485.18828, t_out: usdc, amount_out: 579.8, date: '2022-04-13', portfolio:)
purchase(token: ftm, amount: 235.147, rate: 1.063, date: '2022-04-23', portfolio:)
trade(t_in: lqdr, amount_in: 25.5, t_out: ftm, amount_out: 235.147, date: '2022-04-23', portfolio:)
purchase(token: ape, amount: 46.16424493, rate: 22.4284, date: '2022-04-29', portfolio:)
trade(t_out: mai, amount_out: 42.0706, t_in: ftm, amount_in: 49.453774, date: '2022-04-30', portfolio:)
trade(t_out: ape, amount_out: 46.16424493, t_in: busd, amount_in: 783.13, date: '2022-05-01', portfolio:)
trade(t_out: busd, amount_out: 233.28, t_in: one, amount_in: 3000, date: '2022-05-01', portfolio:)
trade(t_out: one, amount_out: 2000, t_in: jewel, amount_in: 98.34, date: '2022-05-01', portfolio:)
sale(token: jewel, amount: 90, rate: 0, date: '2022-05-01', portfolio:)

Rails.logger.debug 'Built transactions!'

# rubocop:enable Metrics/ParameterLists
# rubocop:enable Naming/VariableName
