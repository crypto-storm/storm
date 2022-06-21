# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chain, type: :model do
  let(:chain) { build(:chain) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(chain).to be_valid
    end

    it 'is not valid without a name' do
      chain.name = nil
      expect(chain).not_to be_valid
    end

    context 'when name is not unique' do
      before { create(:chain, name: chain.name) }

      it { expect(chain).not_to be_valid }
    end
  end

  describe 'associations' do
    it { expect(described_class.reflect_on_association(:transaction_data).macro).to eq(:has_many) }

    it { expect(described_class.reflect_on_association(:native_token).macro).to eq(:has_one) }
  end
end
