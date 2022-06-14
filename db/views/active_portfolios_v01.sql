SELECT p.id AS portfolio_id, t.id, t.name AS token_name,
  (
    SELECT hr.rate
      FROM historic_rates hr
      WHERE hr.token_id = t.id
      ORDER BY hr.date DESC LIMIT 1
  ) rate,
  SUM(td.amount) AS amount
  FROM portfolios p
  JOIN transactions txs ON txs.portfolio_id = p.id
  JOIN transaction_data td ON (td.in_id = txs.id OR td.out_id = txs.id)
  JOIN tokens t on td.token_id = t.id
  GROUP BY p.id, t.id, t.name
