# frozen_string_literal: true

class AddUniqueIndexToHistoricRates < ActiveRecord::Migration[7.0]
  def change
    add_index :historic_rates, %i[token_id date], unique: true
  end
end
