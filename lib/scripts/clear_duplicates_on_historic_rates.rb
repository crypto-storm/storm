# frozen_string_literal: true

# Removes duplicates on historic rates
duplicates_query = <<~SQL
  SELECT hr.token_id, hr.date, COUNT(hr)
  FROM historic_rates hr
  GROUP BY hr.token_id, hr.date
  HAVING COUNT(hr) > 1
SQL

ActiveRecord::Base.connection.execute(duplicates_query).each { |x| Rails.logger.debug x }

remove_duplicates_query = <<~SQL
  DELETE FROM historic_rates a USING historic_rates b
  WHERE a.id < b.id
  AND a.date = b.date
  AND a.token_id = b.token_id
SQL
ActiveRecord::Base.connection.execute(remove_duplicates_query)

# Removes nil rate entries on historic rates
remove_nil_rates_query = <<~SQL
  DELETE FROM historic_rates hr
  WHERE hr.rate IS NULL
SQL
ActiveRecord::Base.connection.execute(remove_nil_rates_query)
