# frozen_string_literal: true

class OverviewController < ApplicationController
  def index
    @assets = BuildPortfolio.call(@portfolio)
    @stats = BuildStats.call(@assets)
    @distribution = @stats.rounded_distribution.transform_keys do |token_id|
      Token.find_by(id: token_id)&.abbr || 'Others'
    end
    @assets = @assets.reject { |_, data| data.amount.zero? }
    @evolution = BuildEvolution.call(@portfolio)
  end
end
