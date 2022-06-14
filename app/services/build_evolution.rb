# frozen_string_literal: true

class BuildEvolution < ApplicationService
  def initialize(portfolio)
    @portfolio = portfolio
    @history = build_yearly_history
  end

  def call
    build_evolutions
  end

  def portfolio_value_for_all_dates
    PortfolioEvolutions.all
  end

  def build_yearly_history
    history = portfolio_value_for_all_dates.map do |entry|
      [entry['date'].to_date, entry['total']]
    end.to_h

    history.reject { |_date, value| value.zero? }
  end

  def build_evolution(dates)
    @history.slice(*dates)
  end

  def build_hourly_ranges
    # now = Time.zone.now
    # daily = (0..24).reduce([]) { |acc, h| acc.push(now - h.hours) }
    # weekly = (0..7).reduce([]) { |acc, d| acc.push(today - d.days) }
  end

  def build_daily_ranges
    today = Time.zone.today

    year_ago = today - 1.year
    yearly_by_day = (year_ago..today)
    yearly_by_month = yearly_by_day.step(1.month.in_days.to_i)
    weekly = yearly_by_day.last(7)
    monthly = yearly_by_day.last(30)
    tri_monthly = yearly_by_day.last(90)

    { yearly_by_month:, yearly_by_day:, weekly:, monthly:, tri_monthly: }
  end

  def build_evolutions
    build_daily_ranges.transform_values { |range| build_evolution(range) }
  end
end
