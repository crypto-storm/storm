# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_20_134638) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chains", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_chains_on_name", unique: true
  end

  create_table "coin_gecko_tokens", force: :cascade do |t|
    t.string "slug"
    t.string "symbol"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exchanges", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_exchanges_on_name", unique: true
  end

  create_table "historic_rates", force: :cascade do |t|
    t.bigint "token_id", null: false
    t.datetime "date", precision: nil
    t.float "rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_id", "date"], name: "index_historic_rates_on_token_id_and_date", unique: true
    t.index ["token_id"], name: "index_historic_rates_on_token_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_portfolios_on_name", unique: true
  end

  create_table "tokens", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "abbr"
    t.bigint "native_chain_id"
    t.index ["native_chain_id"], name: "index_tokens_on_native_chain_id"
  end

  create_table "transaction_data", force: :cascade do |t|
    t.bigint "token_id", null: false
    t.float "amount", null: false
    t.float "rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "in_id"
    t.bigint "out_id"
    t.bigint "location_id", null: false
    t.string "location_type", null: false
    t.index ["in_id"], name: "index_transaction_data_on_in_id"
    t.index ["location_type", "location_id"], name: "index_transaction_data_on_location_type_and_location_id"
    t.index ["out_id"], name: "index_transaction_data_on_out_id"
    t.index ["token_id"], name: "index_transaction_data_on_token_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date", precision: nil
    t.bigint "portfolio_id", default: 1, null: false
    t.index ["portfolio_id"], name: "index_transactions_on_portfolio_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "historic_rates", "tokens"
  add_foreign_key "tokens", "chains", column: "native_chain_id"
  add_foreign_key "transaction_data", "tokens"
  add_foreign_key "transaction_data", "transactions", column: "in_id"
  add_foreign_key "transaction_data", "transactions", column: "out_id"

  create_view "active_portfolios", materialized: true, sql_definition: <<-SQL
      SELECT p.id AS portfolio_id,
      t.id,
      t.name AS token_name,
      ( SELECT hr.rate
             FROM historic_rates hr
            WHERE (hr.token_id = t.id)
            ORDER BY hr.date DESC
           LIMIT 1) AS rate,
      sum(td.amount) AS amount
     FROM (((portfolios p
       JOIN transactions txs ON ((txs.portfolio_id = p.id)))
       JOIN transaction_data td ON (((td.in_id = txs.id) OR (td.out_id = txs.id))))
       JOIN tokens t ON ((td.token_id = t.id)))
    GROUP BY p.id, t.id, t.name;
  SQL
  create_view "portfolio_evolutions", materialized: true, sql_definition: <<-SQL
      SELECT tmp.portfolio_id,
      tmp.date,
      date_part('year'::text, tmp.date) AS year,
      date_part('month'::text, tmp.date) AS month,
      date_part('day'::text, tmp.date) AS day,
      date_part('hour'::text, tmp.date) AS hour,
      date_part('minute'::text, tmp.date) AS minute,
      date_part('second'::text, tmp.date) AS second,
      sum(tmp.total) AS total
     FROM ( SELECT p.id AS portfolio_id,
              hr.date,
              hr.rate,
              tk.id,
              tk.abbr,
              ( SELECT (sum(td_1.amount) * hr.rate)
                     FROM (transactions t_1
                       JOIN transaction_data td_1 ON ((((td_1.in_id = t_1.id) OR (td_1.out_id = t_1.id)) AND (td_1.token_id = tk.id))))
                    WHERE ((t_1.date < hr.date) AND (t_1.portfolio_id = p.id))) AS total
             FROM ((((portfolios p
               JOIN transactions t ON ((t.portfolio_id = p.id)))
               JOIN transaction_data td ON (((td.in_id = t.id) OR (td.out_id = t.id))))
               JOIN tokens tk ON ((td.token_id = tk.id)))
               JOIN historic_rates hr ON ((hr.token_id = tk.id)))
            GROUP BY p.id, tk.id, tk.abbr, hr.date, hr.rate
            ORDER BY hr.date) tmp
    WHERE ((date_part('hour'::text, tmp.date) = (0)::double precision) AND (date_part('minute'::text, tmp.date) = (0)::double precision) AND (date_part('second'::text, tmp.date) = (0)::double precision) AND (tmp.total IS NOT NULL) AND (tmp.total <> (0)::double precision))
    GROUP BY tmp.portfolio_id, tmp.date, (date_part('year'::text, tmp.date)), (date_part('month'::text, tmp.date)), (date_part('day'::text, tmp.date)), (date_part('hour'::text, tmp.date)), (date_part('minute'::text, tmp.date)), (date_part('second'::text, tmp.date))
    ORDER BY (date_part('year'::text, tmp.date)), (date_part('month'::text, tmp.date)), (date_part('day'::text, tmp.date)), (date_part('hour'::text, tmp.date)), (date_part('minute'::text, tmp.date));
  SQL
  create_view "portfolio_overviews", materialized: true, sql_definition: <<-SQL
      SELECT p.id AS portfolio_id,
      t.id,
      t.name AS token_name,
      ( SELECT hr.rate
             FROM historic_rates hr
            WHERE (hr.token_id = t.id)
            ORDER BY hr.date DESC
           LIMIT 1) AS rate,
      sum(td.amount) AS amount
     FROM (((portfolios p
       JOIN transactions txs ON ((txs.portfolio_id = p.id)))
       JOIN transaction_data td ON (((td.in_id = txs.id) OR (td.out_id = txs.id))))
       JOIN tokens t ON ((td.token_id = t.id)))
    GROUP BY p.id, t.id, t.name;
  SQL
end
