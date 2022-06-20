# frozen_string_literal: true

class Portfolio < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :transactions, dependent: :destroy

  def equals?(other)
    name == other.name &&
      transaction_ids == other.transaction_ids
  end
end
