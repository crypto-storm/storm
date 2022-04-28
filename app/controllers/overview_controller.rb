# frozen_string_literal: true

class OverviewController < ApplicationController
  def index
    portfolio = BuildPortfolio.call
    @assets = portfolio.assets
    @stats = BuildStats.call(@assets)
    @distribution = @stats.rounded_distribution.transform_keys do |token_id|
      Token.find_by(id: token_id)&.abbr || 'Others'
    end
    @evolution = portfolio.evolution.reject { |_, value| value.zero? }
  end
end
