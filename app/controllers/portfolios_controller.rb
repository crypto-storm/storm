# frozen_string_literal: true

class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: %i[show edit update destroy]

  def show; end

  def new
    @portfolio = Portfolio.new
  end

  def edit; end

  def create
    @portfolio = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portfolio.update(portfolio_params)
        format.html { redirect_to portfolio_url(@portfolio), notice: 'Token was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @portfolio.destroy

    respond_to do |format|
      format.html do
        redirect_back(fallback_location: overview_index_path, notice: 'Portfolio was successfully destroyed.')
      end
    end
  end

  def change_active
    session[:portfolio_id] = params[:id]

    redirect_to overview_index_path
  end

  private

  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  def portfolio_params
    params.require(:portfolio).permit(:name)
  end
end
