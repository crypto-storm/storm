# frozen_string_literal: true

json.array! @on_chain_tokens, partial: 'on_chain_tokens/on_chain_token', as: :on_chain_token
