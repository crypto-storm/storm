# frozen_string_literal: true

class ValidatePresenceOfRateOnHistoricRate < ActiveRecord::Migration[7.0]
  def up
    change_column :historic_rates, :rate, :float, null: false
  end

  def down
    change_column :historic_rates, :rate, :float, null: true
  end
end
