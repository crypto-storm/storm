require 'rails_helper'

RSpec.describe 'Overview', type: :system do
  let(:ada) { build(:token, :with_rates, name: 'Cardano', abbr: 'ADA') }
  let(:ftm) { build(:token, :with_rates, name: 'Fantom', abbr: 'FTM') }
  let(:eth) { build(:token, :with_rates, name: 'Ethereum', abbr: 'ETH') }
  let(:btc) { build(:token, :with_rates, name: 'Bitcoin', abbr: 'BTC') }
  let(:portfolio) { create(:portfolio, name: 'Main') }
  let(:transactions) { find('#transactions') }

  before do
    create(:transaction, :purchase, portfolio:, token: ada, amount: 10_000, date: Date.today - 9.months)
    create(:transaction, :purchase, portfolio:, token: ftm, amount: 10_000, date: Date.today - 6.months)
    create(:transaction, :purchase, portfolio:, token: eth, amount: 100, date: Date.today - 3.months)
    create(:transaction, :purchase, portfolio:, token: btc, amount: 5, date: Date.today)

    RebuildPortfolioViewsJob.perform_now
  end

  def build_distribution
    assets = BuildPortfolio.call(portfolio)
    stats = BuildStats.call(assets)
    stats.rounded_distribution.transform_keys do |token_id|
      Token.find_by(id: token_id)&.abbr || 'Others'
    end
  end

  describe 'charts' do
    describe 'distribution' do
      let(:distribution_div) { find('#distribution') }

      it 'is correctly presented' do
        visit '/'

        distribution = JSON.parse(distribution_div.find(:xpath, './/div')['data-pie-chart-distribution-value'])

        expect(build_distribution).to eq(distribution)
      end
    end

    describe 'evolution' do
      let(:evolution) { find('#evolution') }

      it 'is correctly presented' do
        visit '/'

        # expect(evolution).to
      end
    end
  end

  describe 'tokens' do
    let(:tokens) { find('#tokens') }

    it 'are correctly presented' do
      visit '/'

      expect(tokens).to have_text('ADA')
      expect(tokens).to have_text('FTM')
      expect(tokens).to have_text('ETH')
      expect(tokens).to have_text('BTC')
    end
  end
end
