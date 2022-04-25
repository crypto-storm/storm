# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :in, foreign_key: { to_table: :tokens }
      t.references :out, foreign_key: { to_table: :tokens }

      t.timestamps
    end
  end
end
