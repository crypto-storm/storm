# frozen_string_literal: true

class Exchange < ApplicationRecord
  include PolymorphicSelect

  validates :name, presence: true, uniqueness: true

  has_many :transaction_data, as: :location, dependent: :destroy
end
