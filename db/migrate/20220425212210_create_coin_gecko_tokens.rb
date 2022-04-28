# frozen_string_literal: true

class CreateCoinGeckoTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :coin_gecko_tokens do |t|
      t.string :slug
      t.string :symbol
      t.string :name

      t.timestamps
    end
  end
end
