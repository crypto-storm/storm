# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exchange, type: :model do
  let(:exchange) { build(:exchange) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(exchange).to be_valid
    end

    it 'is not valid without a name' do
      exchange.name = nil
      expect(exchange).not_to be_valid
    end

    context 'when name is not unique' do
      before { create(:exchange, name: exchange.name) }

      it { expect(exchange).not_to be_valid }
    end
  end

  describe 'associations' do
    it { expect(described_class.reflect_on_association(:transaction_data).macro).to eq(:has_many) }
  end
end
