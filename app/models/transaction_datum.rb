# frozen_string_literal: true

class TransactionDatum < ApplicationRecord
  belongs_to :token
  belongs_to :in, class_name: 'Transaction', optional: true, inverse_of: :tx_in
  belongs_to :out, class_name: 'Transaction', optional: true, inverse_of: :tx_out

  validates :amount, presence: true
  validates :rate, presence: true

  def total
    amount * rate
  end
end
