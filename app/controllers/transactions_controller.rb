# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  def index
    @transactions = Transaction.order(date: :desc).all
  end

  def show; end

  def new
    @transaction = Transaction.new
  end

  def edit; end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.build_tx_in(tx_in_params)
    @transaction.build_tx_out(tx_out_params)

    respond_to do |format|
      if @transaction.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @transaction.build_tx_in(tx_in_params)
      @transaction.build_tx_out(tx_out_params)
      if @transaction.save
        format.html { redirect_to transaction_url(@transaction), notice: 'Transaction was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy

    respond_to do |format|
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
    params.require(:transaction).require(:tx_in).permit(:token_id, :amount)
  end

  def tx_out_params
    params.require(:transaction).require(:tx_out).permit(:token_id, :amount)
  end
end
