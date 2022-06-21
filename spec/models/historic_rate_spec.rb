# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HistoricRate, type: :model do
  let(:token) { create(:token) }
  let(:historic_rate) { build(:historic_rate, token:) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(historic_rate).to be_valid
    end

    it 'is not valid without a date' do
      historic_rate.date = nil
      expect(historic_rate).not_to be_valid
    end

    it 'is not valid without a rate' do
      historic_rate.rate = nil
      expect(historic_rate).not_to be_valid
    end

    it 'is not valid without a token' do
      historic_rate.token = nil
      expect(historic_rate).not_to be_valid
    end

    context 'when date is not unique for token' do
      before do
        create(:historic_rate, token:, date: historic_rate.date)
      end

      it { expect(historic_rate).not_to be_valid }
    end
  end

  describe 'associations' do
    it { expect(described_class.reflect_on_association(:token).macro).to eq(:belongs_to) }
  end
end
