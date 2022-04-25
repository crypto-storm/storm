# frozen_string_literal: true

class AddNativeChainToTokens < ActiveRecord::Migration[7.0]
  def change
    add_reference :tokens, :native_chain, foreign_key: { to_table: :chains }
  end
end
