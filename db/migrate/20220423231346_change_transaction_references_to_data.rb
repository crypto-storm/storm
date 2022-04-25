# frozen_string_literal: true

class ChangeTransactionReferencesToData < ActiveRecord::Migration[7.0]
  def up
    change_table :transactions, bulk: true do |t|
      t.remove :in_id
      t.remove :out_id
    end

    add_reference :transaction_data, :in, foreign_key: { to_table: :transactions }
    add_reference :transaction_data, :out, foreign_key: { to_table: :transactions }
  end

  def down
    change_table :transactions, bulk: true do |t|
      t.references :in, foreign_key: { to_table: :tokens }
      t.references :out, foreign_key: { to_table: :tokens }
    end

    change_table :transaction_data, bulk: true do |t|
      t.remove :in_id
      t.remove :out_id
    end
  end
end
