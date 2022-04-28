# frozen_string_literal: true

class CoinGeckoToken < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true
  validates :symbol, presence: true

  def self.find_by_name(name)
    find_by('name ILIKE ?', name)
  end
end
