# frozen_string_literal: true

# Removes duplicates on historic rates
duplicates_query = <<~SQL
  SELECT hr.token_id, date_part('year', hr.date) AS YEAR, date_part('month', hr.date) AS MONTH, date_part('day', hr.date) AS DAY, date_part('hour', hr.date) AS HOUR, date_part('minute', hr.date) AS MINUTE, ROUND(date_part('second', hr.date)) AS SECOND, COUNT(hr)
      FROM historic_rates hr
      GROUP BY hr.token_id, YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
      HAVING COUNT(hr) > 1
SQL

ActiveRecord::Base.connection.execute(duplicates_query).each { |x| Rails.logger.debug x }

remove_duplicates_query = <<~SQL
  DELETE FROM historic_rates a USING historic_rates b
  WHERE a.id < b.id
  AND date_part('year', a.date) = date_part('year', b.date)
  AND date_part('month', a.date) = date_part('month', b.date)
  AND date_part('day', a.date) = date_part('day', b.date)
  AND date_part('hour', a.date) = date_part('hour', b.date)
  AND date_part('minute', a.date) = date_part('minute', b.date)
  AND ROUND(date_part('second', a.date)) = ROUND(date_part('second', b.date))
  AND a.token_id = b.token_id
SQL
ActiveRecord::Base.connection.execute(remove_duplicates_query)

# Removes nil rate entries on historic rates
remove_nil_rates_query = <<~SQL
  DELETE FROM historic_rates hr
  WHERE hr.rate IS NULL
SQL
ActiveRecord::Base.connection.execute(remove_nil_rates_query)
