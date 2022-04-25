# frozen_string_literal: true

class SalesController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.build_tx_out(tx_out_params)

    respond_to do |format|
      if @transaction.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def transaction_params
    params.permit(:date)
  end

  def tx_out_params
    params.require(:tx_out).permit(:token_id, :amount, :rate)
  end
end
