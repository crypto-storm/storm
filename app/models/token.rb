# frozen_string_literal: true

class Token < ApplicationRecord
  has_one_attached :logo

  belongs_to :native_chain, class_name: 'Chain', optional: true, inverse_of: :native_token

  has_many :transaction_data, dependent: :destroy
  has_many :historic_rates, dependent: :destroy

  validates :name, presence: true
  validates :abbr, presence: true

  def equals?(other)
    name == other.name &&
      abbr == other.abbr &&
      native_chain == other.native_chain &&
      transaction_datum_ids == other.transaction_datum_ids &&
      historic_rate_ids == other.historic_rate_ids
  end
end
