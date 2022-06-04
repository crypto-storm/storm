# frozen_string_literal: true

class CreateExchanges < ActiveRecord::Migration[7.0]
  def change
    create_table :exchanges do |t|
      t.string :name, index: { unique: true }

      t.timestamps
    end
  end
end
