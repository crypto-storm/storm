# frozen_string_literal: true

module CurrentPortfolio
  extend ActiveSupport::Concern

  included do
    before_action :set_current_portfolio!
  end

  private

  def set_current_portfolio!
    @portfolio = current_portfolio
  end

  def current_portfolio
    Portfolio.find_by(id: session[:portfolio_id]) || Portfolio.first
  end
end
