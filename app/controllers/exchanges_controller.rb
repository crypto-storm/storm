# frozen_string_literal: true

class ExchangesController < ApplicationController
  before_action :set_exchange, only: %i[show edit update destroy]

  def index
    @exchanges = Exchange.includes(logo_attachment: :blob).order(:created_at)
  end

  def show; end

  def new
    @exchange = Exchange.new
  end

  def edit; end

  def create
    @exchange = Exchange.new(exchange_params)

    respond_to do |format|
      if @exchange.save
        format.html { redirect_to exchange_url(@exchange), notice: 'Exchange was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @exchange.update(exchange_params)
        format.turbo_stream
        format.html { redirect_to exchange_url(@exchange), notice: 'Exchange was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @exchange.destroy

    respond_to do |format|
      format.html { redirect_to exchanges_url, notice: 'Exchange was successfully destroyed.' }
    end
  end

  private

  def set_exchange
    @exchange = Exchange.find(params[:id])
  end

  def exchange_params
    params.require(:exchange).permit(:name, :logo)
  end
end
