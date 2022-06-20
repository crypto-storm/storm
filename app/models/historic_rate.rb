# frozen_string_literal: true

class HistoricRate < ApplicationRecord
  belongs_to :token

  validates :date, presence: true, uniqueness: { scope: :token_id }
  validates :rate, presence: true
end
