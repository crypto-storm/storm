# frozen_string_literal: true

class BuildPortfolio < ApplicationService
  def initialize(portfolio)
    @portfolio = portfolio
  end

  def call
    build_portfolio
  end

  private

  def build_portfolio
    PortfolioOverviews.where(portfolio_id: @portfolio.id).map do |data|
      id = data['id']
      rate = data['rate'] || 0
      amount = data['amount'] || 0
      total = rate * amount
      [id, OpenStruct.new(rate:, total:, amount:)]
    end.to_h
  end
end
