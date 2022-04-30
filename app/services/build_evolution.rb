# frozen_string_literal: true

class BuildEvolution < ApplicationService
  def initialize
    @history = build_yearly_history
  end

  def call
    build_evolutions
  end

  private

  def portfolio_value_for_date(date)
    query = <<-SQL
      SELECT tk.abbr, (SUM(td.amount) * hr.rate) AS value
      FROM transactions t
      JOIN transaction_data td ON td.in_id = t.id OR td.out_id = t.id
      JOIN tokens tk ON tk.id = td.token_id
      JOIN historic_rates hr ON hr.token_id = tk.id AND hr.date = '#{date}'
      WHERE t.date <= '#{date}'
      GROUP BY tk.abbr, hr.rate
    SQL

    sanitized_query = ActiveRecord::Base.sanitize_sql(query)
    ActiveRecord::Base.connection.execute(sanitized_query)
  end

  def build_yearly_history
    today = Time.zone.today
    year_ago = today - 1.year

    history = (year_ago..today).index_with do |date|
      portfolio_value_for_date(date).sum { |x| x['value'] || 0 }
    end

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
