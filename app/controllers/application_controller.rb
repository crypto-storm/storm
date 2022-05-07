# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_portfolio!

  def current_portfolio
    Portfolio.find_by(id: session[:portfolio_id]) || Portfolio.first
  end

  private

  def set_current_portfolio!
    @portfolio = current_portfolio
  end
end
