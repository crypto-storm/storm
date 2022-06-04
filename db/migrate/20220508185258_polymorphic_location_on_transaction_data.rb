# frozen_string_literal: true

class PolymorphicLocationOnTransactionData < ActiveRecord::Migration[7.0]
  def change
    change_table :transaction_date, bulk: true do |t|
      t.bigint :location_id, null: false
      t.string :location_type, null: false
    end

    add_index :transaction_data, %i[location_type location_id]
  end
end
