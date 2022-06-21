# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  def index
    tx_preloads = { location: [logo_attachment: :blob], token: [logo_attachment: :blob] }
    @transactions = Transaction.includes(tx_in: tx_preloads, tx_out: tx_preloads)
                               .where(portfolio: @portfolio)
                               .order(date: :desc, created_at: :desc)
  end

  def show; end

  def new
    @transaction = Transaction.new
  end

  def edit
    @transaction.tx_out.amount = @transaction.tx_out.amount.abs
  end

  def create
    @transaction = Transaction.new(transaction_params.merge({ portfolio: @portfolio }))
    @transaction.build_tx_in(tx_in_params)
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
    @transaction.tx_in.update!(tx_in_params)
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

  def destroy
    @transaction.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:date)
  end

  def tx_in_params
    permitted = params.require(:transaction).require(:tx_in).permit(:token_id, :amount, :location)
    adjust_location(permitted)
  end

  def tx_out_params
    permitted = params.require(:transaction).require(:tx_out).permit(:token_id, :amount, :location)
    adjust_location(permitted)
  end
end
