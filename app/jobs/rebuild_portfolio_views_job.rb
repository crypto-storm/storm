# frozen_string_literal: true

class RebuildPortfolioViewsJob < ApplicationJob
  queue_as :default

  def perform
    PortfolioOverviews.refresh
    PortfolioEvolutions.refresh
  end
end
