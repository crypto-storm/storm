# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionDatum, type: :model do
  let(:tx) { build(:transaction_datum) }

  describe 'callbacks' do
    let(:tx_out) { build(:transaction_datum, :out) }

    it 'amount is positive' do
      expect(tx_out.amount > 0).to be true
    end

    it 'makes amount negative on sale' do
      tx_out.save!
      expect(tx_out.amount < 0).to be true
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(tx).to be_valid
    end

    it 'is not valid without a token' do
      tx.token = nil
      expect(tx).not_to be_valid
    end

    it 'is not valid without a location' do
      tx.location = nil
      expect(tx).not_to be_valid
    end

    it 'is not valid without a rate' do
      tx.rate = nil
      expect(tx).not_to be_valid
    end

    it 'is not valid without an amount' do
      tx.amount = nil
      expect(tx).not_to be_valid
    end
  end

  describe 'associations' do
    it { expect(described_class.reflect_on_association(:token).macro).to eq(:belongs_to) }
    it { expect(described_class.reflect_on_association(:location).macro).to eq(:belongs_to) }
    it { expect(described_class.reflect_on_association(:in).macro).to eq(:belongs_to) }
    it { expect(described_class.reflect_on_association(:out).macro).to eq(:belongs_to) }
  end
end
