# frozen_string_literal: true

class CreatePortfolioEvolutions < ActiveRecord::Migration[7.0]
  def change
    create_view :portfolio_evolutions, materialized: true
  end
end
