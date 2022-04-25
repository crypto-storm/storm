# frozen_string_literal: true

json.extract! on_chain_token, :id, :name, :token_id, :chain_id, :created_at, :updated_at
json.url on_chain_token_url(on_chain_token, format: :json)
