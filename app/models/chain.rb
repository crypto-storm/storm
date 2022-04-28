# frozen_string_literal: true

class Chain < ApplicationRecord
  has_one_attached :logo
  has_one :native_token, class_name: 'Token', foreign_key: 'native_chain_id', dependent: :destroy,
                         inverse_of: :native_chain

  has_many :on_chain_tokens, dependent: :destroy
end