# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:token) { create(:token) }
  let(:portfolio) { create(:portfolio) }

  let(:trade) { build(:transaction, :trade, token:, portfolio:) }
  let(:purchase) { build(:transaction, :purchase, token:, portfolio:) }

  describe 'validations' do
    it 'is not valid without a tx' do
      purchase.tx_in = nil
      expect(purchase).not_to be_valid
    end
  end

  it 'calls RebuildPortfolioViewsJob after commit' do
    ActiveJob::Base.queue_adapter = :test
    purchase.save!
    expect(RebuildPortfolioViewsJob).to have_been_enqueued
  end

  describe 'associations' do
    it { expect(described_class.reflect_on_association(:portfolio).macro).to eq(:belongs_to) }
    it { expect(described_class.reflect_on_association(:tx_in).macro).to eq(:has_one) }
    it { expect(described_class.reflect_on_association(:tx_out).macro).to eq(:has_one) }
  end
end
