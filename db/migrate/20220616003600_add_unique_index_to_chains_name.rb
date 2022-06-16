# frozen_string_literal: true

class AddUniqueIndexToChainsName < ActiveRecord::Migration[7.0]
  def change
    add_index :chains, :name, unique: true
  end
end
