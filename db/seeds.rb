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

# Exchanges
binance = Exchange.create(name: 'Binance')

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

near_protocol = Chain.new(name: 'NEAR Protocol')
set_logo(near_protocol, 'near.jpeg')

metis = Chain.new(name: 'Metis')
set_logo(metis, 'metis.png')

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

metis_token = Token.new(name: 'Metis Token', abbr: 'METIS', native_chain: metis)
set_logo(metis_token, 'metis.png')

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

# Here I have added some example transactions, feel free to either create yours as a seed or just add them
# through the interface and keep a pg-dump just in case you lose them.
purchase(token: dai, amount: 109.89, rate: 1, date: '2021-11-09', portfolio:, location: ethereum)
purchase(token: ada, amount: 105.763, rate: 2.27, date: '2021-11-09', portfolio:, location: cardano)
purchase(token: geist, amount: 197.778, rate: 0.6, date: '2021-11-15', portfolio:, location: fantom)
purchase(token: avax, amount: 1.346, rate: 97.98, date: '2021-11-16', portfolio:, location: avalanche)
trade(t_out: avax, amount_out: 1.3, location_out: avalanche, location_in: avalanche, t_in: wsOHM, amount_in: 0.004,
      date: '2021-11-16', portfolio:)
purchase(token: ftm, amount: 58, rate: 2.36, date: '2021-11-23', portfolio:, location: fantom)
trade(t_out: ape, amount_out: 46.16424493, location_out: binance, location_in: binance, t_in: busd, amount_in: 783.13,
      date: '2022-05-01', portfolio:)

Rails.logger.debug 'Built transactions!'

# rubocop:enable Metrics/ParameterLists
# rubocop:enable Naming/VariableName
