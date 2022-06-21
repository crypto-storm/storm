# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  let(:portfolio) { build(:portfolio) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(portfolio).to be_valid
    end

    it 'is not valid without a name' do
      portfolio.name = nil
      expect(portfolio).not_to be_valid
    end
  end

  describe 'associations' do
    it { expect(described_class.reflect_on_association(:transactions).macro).to eq(:has_many) }
  end
end
