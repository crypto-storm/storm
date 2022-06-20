# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Purchase', type: :model do
  let(:token) { create(:token) }
  let(:portfolio) { create(:portfolio) }

  let(:sale) { build(:transaction, :sale, token:, portfolio:) }
  let(:loss) { build(:transaction, :sale, token:, portfolio:, rate: 0) }

  describe 'validations' do
    describe 'with liquidity' do
      before do
        create(:transaction, :purchase, token:, portfolio:, amount: 1000)
      end

      it 'is valid with valid attributes' do
        expect(sale).to be_valid
      end
    end
  end

  it 'has correct type' do
    expect(sale.type).to be(:sale)
  end

  it 'with rate 0 is loss' do
    expect(loss.loss?).to be true
  end
end
