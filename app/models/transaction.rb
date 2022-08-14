# frozen_string_literal: true

class Transaction < ApplicationRecord
  has_one :tx_in, class_name: 'TransactionDatum', dependent: :destroy, foreign_key: :in_id, inverse_of: :in
  has_one :tx_out, class_name: 'TransactionDatum', dependent: :destroy, foreign_key: :out_id, inverse_of: :out
  belongs_to :portfolio

  validate :not_empty
  validate :enough_liquidity

  before_create :set_rates
  after_commit :reset_views

  scope :in_interval, ->(first, last) { where(date: first..last) }

  def set_rates
    return unless trade?

    tx_in.rate = tx_out.amount / tx_in.amount
    tx_out.rate = tx_in.amount / tx_out.amount
  end

  def profit?
    purchase? && tx_in.rate.zero?
  end

  def loss?
    sale? && tx_out.rate.zero?
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

  def equals?(other)
    (tx_in.nil? || tx_in.equals?(other.tx_in)) &&
      (tx_out.nil? || tx_out&.equals?(other.tx_out)) &&
      portfolio == other.portfolio
  end

  private

  def reset_views
    RebuildPortfolioViewsJob.perform_later
  end

  # rubocop:disable Metrics/AbcSize
  def enough_liquidity
    return if tx_out.nil? || errors.any? || purchase?

    liquidity = BuildPortfolio.call(portfolio)[tx_out.token.id]

    return unless liquidity&.amount.to_i < tx_out&.amount.to_i

    errors.add(:base, "Not enough #{tx_out.token.abbr} to finish #{type}!")
  end
  # rubocop:enable Metrics/AbcSize

  def not_empty
    errors.add(:base, 'Must have a transaction datum') unless tx_in.present? || tx_out.present?
  end
end
