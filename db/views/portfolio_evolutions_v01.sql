SELECT
  tmp.portfolio_id,
  date AS DATE,
  date_part('year', date) AS YEAR,
  date_part('month', date) AS MONTH,
  date_part('day', date) AS DAY,
  date_part('hour', date) AS HOUR,
  date_part('minute', date) AS MINUTE,
  date_part('second', date) AS SECOND,
  SUM(total) AS TOTAL
  FROM (
    SELECT p.id AS portfolio_id, hr.date, hr.rate, tk.id, tk.abbr,
        (
          SELECT SUM(td.amount) * hr.rate
            FROM transactions t
            JOIN transaction_data td ON (td.in_id = t.id OR td.out_id = t.id) AND td.token_id = tk.id
            WHERE t.date < hr.date
            AND t.portfolio_id = p.id
        ) total
      FROM portfolios p
      JOIN transactions t ON t.portfolio_id = p.id
      JOIN transaction_data td ON (td.in_id = t.id OR td.out_id = t.id)
      JOIN tokens tk ON td.token_id = tk.id
      JOIN historic_rates hr ON hr.token_id = tk.id
      GROUP BY p.id, tk.id, tk.abbr, hr.date, hr.rate
      ORDER BY hr.date
  ) AS tmp
  WHERE date_part('hour', date) = 0 AND date_part('minute', date) = 0 AND date_part('second', date) = 0 AND TOTAL IS NOT NULL AND TOTAL != 0
  GROUP BY tmp.portfolio_id, DATE, YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
  ORDER BY YEAR, MONTH, DAY, HOUR, MINUTE
