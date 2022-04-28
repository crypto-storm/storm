# frozen_string_literal: true

class CreateHistoricRates < ActiveRecord::Migration[7.0]
  def change
    create_table :historic_rates do |t|
      t.references :token, null: false, foreign_key: true
      t.date :date
      t.float :rate

      t.timestamps
    end
  end
end
