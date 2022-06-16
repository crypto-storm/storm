# frozen_string_literal: true

class CreatePortfolioOverviews < ActiveRecord::Migration[7.0]
  def change
    create_view :portfolio_overviews, materialized: true
  end
end
