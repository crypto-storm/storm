# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Token, type: :model do
  let(:token) { build(:token) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(token).to be_valid
    end

    it 'is not valid without a name' do
      token.name = nil
      expect(token).not_to be_valid
    end

    it 'is not valid without an abbr' do
      token.abbr = nil
      expect(token).not_to be_valid
    end
  end

  describe 'associations' do
    it { expect(described_class.reflect_on_association(:native_chain).macro).to eq(:belongs_to) }

    it { expect(described_class.reflect_on_association(:transaction_data).macro).to eq(:has_many) }

    it { expect(described_class.reflect_on_association(:historic_rates).macro).to eq(:has_many) }
  end
end
