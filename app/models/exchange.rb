# frozen_string_literal: true

class Exchange < ApplicationRecord
  include PolymorphicSelect

  has_one_attached :logo
  validates :name, presence: true, uniqueness: true

  has_many :transaction_data, as: :location, dependent: :destroy

  def equals?(other)
    name == other.name &&
      transaction_datum_ids == other.transaction_datum_ids
  end
end
