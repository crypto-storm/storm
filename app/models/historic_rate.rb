# frozen_string_literal: true

class HistoricRate < ApplicationRecord
  belongs_to :token

  validates :date, presence: true
  validates :rate, presence: true

  scope :with_rate, -> { where.not(rate: nil) }
end
