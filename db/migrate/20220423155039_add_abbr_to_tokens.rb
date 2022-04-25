# frozen_string_literal: true

class AddAbbrToTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :tokens, :abbr, :string
  end
end
