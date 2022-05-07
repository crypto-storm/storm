# frozen_string_literal: true

class AddPortfoliosReferenceOnTransactions < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :transactions, :portfolio, null: false, default: 1
  end
end
