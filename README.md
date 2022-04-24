# Storm

An open source crypto portfolio tracker built entirely on Rails 7.
Made essentially with personal use in mind, but with the capability to expand beyond that.

## Motivation

I've been in crypto since August 2021 and it's been a wonderful journey from the beggining.
Everything feels super interesting and there's a lot to learn from an investing and a technological perspective.

As I began investing, naturally I started looking for ways to keep track of investments I've made.
At first, when I wasn't doing much, it was simple to keep some entries written manually either on a notebook or an excel sheet.
This got difficult to maintain really quickly. And, of course, investment data isn't really two dimensional to work well on a sheet.

This lead me to try to find software that keeps track of things for me.
With the lack of a perfect solution, I've been motivated to build a portfolio tracker for a while and I'm finally doing it.

I am actively trying to solve shortcomings that I've found on other portfolio trackers so I think it's worth listing what I can call of my "competition".
Their shortcomings is what I'm trying to solve while keeping advantages that interest me.

## Other software

This list should grow as I investigate deeper into other solutions. So far, I've used 3 portfolio/wallet trackers.

### [Zapper](https://zapper.fi/)

[Zapper](https://zapper.fi/dashboard) was the first wallet tracker I used and it works really well. You add a wallet address and it tracks your token values on every chain.
A big bonus is that it manages to track your LP positions and also lists how much you have as rewards.

However, being a wallet tracker, there's some functionality that you lose. If a chain isn't supported then you can't track it.
Ideally I want Zapper's functionality on top of a regular portfolio tracker.

Pros:
  * Automatically adjusts according to whatever you're holding.
  * Keeps track of defi open positions and rewards
  * Very simple to use
  * Free

Cons:
  * Some syncing issues
  * Being a wallet tracker, it's not easy to track your entire portfolio there (I don't like bundles)
  * No charts

### [CoinMarketCap](https://coinmarketcap.com/)

[CoinMarketCap portfolio tracker](https://coinmarketcap.com/portfolio-tracker/) is very cool since it directly uses CMC prices for every asset.
Since CMC has info about a ton of assets, naturally, you can track pretty much whatever there.

However, the whole process is manual which makes it a bit more complicated.
The most annoying thing about CMC though is that it doesn't have the concept of trades.
Let's say I trade FTM for USDC, keeping my portfolio value at the same point.
To do that on CMC I need to add a sale for FTM and a buy for USDC.
This gets super annoying to maintain and tracks your assets rather poorly.

Pros:
  * Can track pretty much whatever
  * Uses CMC price feeds which are spot on
  * Has a portfolio evolution chart
  * Free

Cons:
  * Only manual tracking
  * Awful UX for managing on-chain trades
  * Can't track defi
  * Could have more charts

### [CoinTracker](https://www.cointracker.io/)

[CoinTracker](https://www.cointracker.io/) has been a joy to use so far. The only problem with this one is that most of the features are paid.
It's also a wallet tracker and I've only used it for one chain in particular but it has diversity for others (major chains are included).
They also try to solve the problem of helping with how taxes should be calculated which is very much out of scope for what I intend to do at first.

It also keeps track of activity for your wallets. If you receive random scam tokens for example, that will be part of their e-mail reports.

Pros:
  * Wallet tracking but you can combine wallets fairly easily
  * Report of transactions for your wallets
  * Helps with taxing
  * Charts (plural :rocket:)

Cons:
  * Doesn't track defi
  * No manual input
  * Most interesting features are paid

## Roadmap

As mentioned under Motivation, for now, I'm trying to solve my own problem.
All I care about is knowing how much I have invested on crypto and how has it progressed relative to fiat over time.
I do not care for tax assistance or for tracking wallets automatically.
I am more than fine in relying in myself to build what truly is my portfolio at the moment.

So this repository will become public when the following features are ready:
  * Manual input of transactions
  * Basic tracking of overall value of the portfolio in fiat
  * Basic charts for portfolio evolution over time
  * Decent UI

That will correspond to version 0.1.0 and it will be good enough for my own personal use.
By adding users I can encapsulate the above functionality and host it on somewhere.
Then there's a whole lot of features that can be done to make the process less manual.
