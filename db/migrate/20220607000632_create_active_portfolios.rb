# frozen_string_literal: true

class CreateActivePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_view :active_portfolios, materialized: true
  end
end
