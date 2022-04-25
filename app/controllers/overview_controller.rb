# frozen_string_literal: true

class OverviewController < ApplicationController
  def index
    @assets = BuildPortfolio.call
  end
end
