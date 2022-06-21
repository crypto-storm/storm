# frozen_string_literal: true

class TransactionDatum < ApplicationRecord
  belongs_to :token
  belongs_to :location, polymorphic: true

  belongs_to :in, class_name: 'Transaction', optional: true, inverse_of: :tx_in
  belongs_to :out, class_name: 'Transaction', optional: true, inverse_of: :tx_out

  validates :amount, presence: true
  validates :rate, presence: true

  before_save :make_amount_negative

  def total
    amount * rate
  end

  def equals?(other)
    token.equals?(other.token) &&
      location.equals?(other.location) &&
      amount == other.amount &&
      rate == other.rate
  end

  private

  def make_amount_negative
    return unless out.present? && amount.positive?

    self.amount = -amount
  end
end
