# frozen_string_literal: true

class OnChainToken < ApplicationRecord
  belongs_to :token
  belongs_to :chain
end
