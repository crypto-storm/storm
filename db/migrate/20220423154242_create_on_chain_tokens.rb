# frozen_string_literal: true

class CreateOnChainTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :on_chain_tokens do |t|
      t.string :name
      t.references :token, null: false, foreign_key: true
      t.references :chain, null: false, foreign_key: true

      t.timestamps
    end
  end
end
