# frozen_string_literal: true

class Portfolio < ApplicationRecord
  validates :name, presence: true

  has_many :transactions, dependent: :destroy
end
