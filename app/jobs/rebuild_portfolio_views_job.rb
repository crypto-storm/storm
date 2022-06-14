# frozen_string_literal: true

class RebuildPortfolioViewsJob < ApplicationJob
  queue_as :default

  def perform
    ActivePortfolios.refresh
    PortfolioEvolutions.refresh
  end
end
