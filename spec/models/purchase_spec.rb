# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Purchase', type: :model do
  let(:token) { create(:token) }
  let(:portfolio) { create(:portfolio) }

  let(:purchase) { build(:transaction, :purchase, token:, portfolio:) }
  let(:profit) { build(:transaction, :purchase, token:, portfolio:, rate: 0) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(purchase).to be_valid
    end
  end

  it 'has correct type' do
    expect(purchase.type).to be(:purchase)
  end

  it 'with rate 0 is profit' do
    expect(profit.profit?).to be true
  end
end
