# frozen_string_literal: true

class ChainsController < ApplicationController
  before_action :set_chain, only: %i[edit update destroy]

  def index
    @chains = Chain.includes(logo_attachment: :blob).order(:created_at)
  end

  def new
    @chain = Chain.new
  end

  def edit; end

  def create
    @chain = Chain.new(chain_params)

    respond_to do |format|
      if @chain.save
        format.html { redirect_to chain_url(@chain), notice: 'Chain was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @chain.update(chain_params)
        format.turbo_stream
        format.html { redirect_to chain_url(@chain), notice: 'Chain was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @chain.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chains_url, notice: 'Chain was successfully destroyed.' }
    end
  end

  private

  def set_chain
    @chain = Chain.find(params[:id])
  end

  def chain_params
    params.require(:chain).permit(:name, :logo)
  end
end
