# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trade', type: :model do
  let(:token) { create(:token) }
  let(:portfolio) { create(:portfolio) }

  let(:trade) { build(:transaction, :trade, token_in: token, token_out: token, portfolio:) }
  let(:purchase) { build(:transaction, :purchase, token:, portfolio:) }

  describe 'validations' do
    describe 'with liquidity' do
      before { create(:transaction, :purchase, token:, portfolio:, amount: 1000) }

      it 'is valid with valid attributes' do
        expect(trade).to be_valid
      end
    end
  end

  it 'has correct type' do
    expect(trade.type).to be(:trade)
  end

  describe 'automatic rates' do
    let(:token_in) { build(:token) }
    let(:token_out) { build(:token) }
    let(:tx_in) { build(:transaction_datum, amount: 1000, token: token_in) }
    let(:tx_out) { build(:transaction_datum, amount: 500, token: token_out) }

    describe 'are correctly calculated for' do
      let(:trade) { build(:transaction, :trade, tx_in:, tx_out:, portfolio:) }

      before do
        create(:transaction, :purchase, token: token_out, portfolio:, amount: 10_000)
        PortfolioOverviews.refresh
      end

      it 'tx_out' do
        trade.save!
        expect(trade.tx_out.rate).to eq(2)
      end

      it 'tx_in' do
        trade.save!
        expect(trade.tx_in.rate).to eq(0.5)
      end
    end
  end
end
