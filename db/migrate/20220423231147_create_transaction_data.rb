# frozen_string_literal: true

class CreateTransactionData < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_data do |t|
      t.references :token, null: false, foreign_key: true
      t.float :amount, null: false
      t.float :rate, null: false

      t.timestamps
    end
  end
end
