# frozen_string_literal: true

class Transaction < ApplicationRecord
  has_one :tx_in, class_name: 'TransactionDatum', dependent: :destroy, foreign_key: :in_id, inverse_of: :in
  has_one :tx_out, class_name: 'TransactionDatum', dependent: :destroy, foreign_key: :out_id, inverse_of: :out

  validate :not_empty
  validate :enough_liquidity

  before_create :set_rates

  scope :in_interval, ->(first, last) { where(date: first..last) }

  def set_rates
    return unless trade?

    tx_in.rate = tx_out.amount / tx_in.amount
    tx_out.rate = tx_in.amount / tx_out.amount
  end

  def purchase?
    type == :purchase
  end

  def sale?
    type == :sale
  end

  def trade?
    type == :trade
  end

  def type
    if tx_in.present? && tx_out.present?
      :trade
    elsif tx_in.present?
      :purchase
    elsif tx_out.present?
      :sale
    end
  end

  private

  def enough_liquidity
    return if purchase?

    liquidity = BuildPortfolio.call[tx_out.token.id]

    errors.add(:base, "Not enough #{tx_out.token.abbr} to finish #{type}!") if liquidity < tx_out.amount
  end

  def not_empty
    errors.add(:base, 'Must have a transaction datum') unless tx_in.present? || tx_out.present?
  end
end