# frozen_string_literal: true

# rubocop:disable Naming/VariableName

def set_logo(object, filename)
  path = Rails.root.join('app/assets/images/')
  object.logo.attach(io: File.open(path.join(filename)), filename:)
  object.save
end

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
set_logo(exc, 'exc.svg')

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

Rails.logger.debug 'Built ERCs!'

# Transactions
t = Transaction.new(date: '2021-10-03')
t.build_tx_in(token: geist, amount: 197.778, rate: 0.6)
t.save(validate: false)

t = Transaction.new(date: '2021-10-10')
t.build_tx_in(token: wsOHM, amount: 0.004, rate: 27_007.5)
t.save(validate: false)

t = Transaction.new(date: '2021-11-03')
t.build_tx_in(token: ada, amount: 88.87, rate: 1.53)
t.save(validate: false)

t = Transaction.new(date: '2021-12-03')
t.build_tx_in(token: ada, amount: 85, rate: 1.26)
t.save(validate: false)

t = Transaction.new(date: '2021-12-10')
t.build_tx_in(token: one, amount: 100, rate: 0.27)
t.save(validate: false)

t = Transaction.new(date: '2021-12-10')
t.build_tx_in(token: jewel, amount: 1)
t.build_tx_out(token: one, amount: 75)
t.save(validate: false)

t = Transaction.new(date: '2022-01-03')
t.build_tx_in(token: ftm, amount: 40, rate: 2.5)
t.save(validate: false)

t = Transaction.new(date: '2022-01-03')
t.build_tx_in(token: usdc, amount: 210, rate: 1)
t.save(validate: false)

t = Transaction.new(date: '2022-01-10')
t.build_tx_in(token: avax, amount: 0.715, rate: 90.657)
t.save(validate: false)

t = Transaction.new(date: '2022-01-15')
t.build_tx_in(token: near, amount: 1, rate: 25)
t.save(validate: false)

t = Transaction.new(date: '2022-02-03')
t.build_tx_in(token: ftm, amount: 83, rate: 1.95)
t.save(validate: false)

t = Transaction.new(date: '2022-02-10')
t.build_tx_in(token: ftm, amount: 62.11, rate: 1.739)
t.save(validate: false)

t = Transaction.new(date: '2022-02-13')
t.build_tx_in(token: mim, amount: 275, rate: 1)
t.save(validate: false)

t = Transaction.new(date: '2022-02-13')
t.build_tx_in(token: dai, amount: 175, rate: 1)
t.save(validate: false)

t = Transaction.new(date: '2022-02-13')
t.build_tx_in(token: usdc, amount: 100, rate: 1)
t.save(validate: false)

t = Transaction.new(date: '2022-02-13')
t.build_tx_in(token: usdt, amount: 100, rate: 1)
t.save(validate: false)

t = Transaction.new(date: '2022-02-18')
t.build_tx_in(token: ftm, amount: 157)
t.build_tx_out(token: usdc, amount: 220)
t.save(validate: false)

t = Transaction.new(date: '2022-02-19')
t.build_tx_in(token: our, amount: 295_329.63, rate: 0.000147)
t.build_tx_out(token: dai, amount: 50, rate: 5906.5926)
t.save(validate: false)

t = Transaction.new(date: '2022-02-20')
t.build_tx_in(token: ftm, amount: 8)
t.build_tx_out(token: dai, amount: 10)
t.save(validate: false)

t = Transaction.new(date: '2022-02-20')
t.build_tx_in(token: medal, amount: 155.60)
t.build_tx_out(token: dai, amount: 10)
t.save(validate: false)

t = Transaction.new(date: '2022-02-23')
t.build_tx_in(token: ftm, amount: 9)
t.build_tx_out(token: medal, amount: 155.60)
t.save(validate: false)

t = Transaction.new(date: '2022-03-03')
t.build_tx_in(token: exc, amount: 6)
t.build_tx_out(token: ftm, amount: 10)
t.save(validate: false)

t = Transaction.new(date: '2022-03-07')
t.build_tx_in(token: boo, amount: 6)
t.build_tx_out(token: ftm, amount: 63.26)
t.save(validate: false)

t = Transaction.new(date: '2022-03-07')
t.build_tx_in(token: xBOO, amount: 3.4)
t.build_tx_out(token: boo, amount: 6)
t.save(validate: false)

t = Transaction.new(date: '2022-03-10')
t.build_tx_in(token: ftm, amount: 6, rate: 0)
t.save(validate: false)

t = Transaction.new(date: '2022-03-15')
t.build_tx_out(token: usdc, amount: 44, rate: 0)
t.save(validate: false)

t = Transaction.new(date: '2022-03-18')
t.build_tx_in(token: ftm, amount: 17.7)
t.build_tx_out(token: exc, amount: 6)
t.save(validate: false)

t = Transaction.new(date: '2022-03-18')
t.build_tx_in(token: tomb, amount: 18.8, rate: 0)
t.save(validate: false)

t = Transaction.new(date: '2022-03-21')
t.build_tx_in(token: dai, amount: 28.92)
t.build_tx_out(token: ftm, amount: 20.02)
t.save(validate: false)

t = Transaction.new(date: '2022-04-13')
t.build_tx_in(token: ftm, amount: 456.8)
t.build_tx_out(token: usdc, amount: 545.9)
t.save(validate: false)

t = Transaction.new(date: '2022-04-23')
t.build_tx_in(token: lqdr, amount: 25.5, rate: 10)
t.save(validate: false)

Rails.logger.debug 'Built transactions!'
# rubocop:enable Naming/VariableName
