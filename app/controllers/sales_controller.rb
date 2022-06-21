# frozen_string_literal: true

class SalesController < ApplicationController
  before_action :set_transaction, only: %i[edit update]

  def new
    @transaction = Transaction.new
  end

  def edit
    @transaction.tx_out.amount = @transaction.tx_out.amount.abs
  end

  def create
    @transaction = Transaction.new(transaction_params.merge({ portfolio: @portfolio }))
    @transaction.build_tx_out(tx_out_params)

    respond_to do |format|
      if @transaction.save!
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @transaction.tx_out.update!(tx_out_params)

    respond_to do |format|
      if @transaction.valid?
        format.turbo_stream
        format.html { redirect_to transaction_url(@transaction), notice: 'Transaction was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.permit(:date)
  end

  def tx_out_params
    permitted = params.require(:tx_out).permit(:token_id, :amount, :rate, :location)
    adjust_location(permitted)
  end
end
