# frozen_string_literal: true

class Exchange < ApplicationRecord
  include PolymorphicSelect

  has_one_attached :logo
  validates :name, presence: true, uniqueness: true

  has_many :transaction_data, as: :location, dependent: :destroy
end
