# frozen_string_literal: true

class Token < ApplicationRecord
  has_one_attached :logo

  belongs_to :native_chain, class_name: 'Chain', optional: true, inverse_of: :native_token

  has_many :transaction_data, dependent: :destroy
  has_many :historic_rates, dependent: :destroy

  validates :name, presence: true
  validates :abbr, presence: true
end
