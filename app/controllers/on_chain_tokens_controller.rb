# frozen_string_literal: true

class OnChainTokensController < ApplicationController
  before_action :set_on_chain_token, only: %i[show edit update destroy]

  # GET /on_chain_tokens or /on_chain_tokens.json
  def index
    @on_chain_tokens = OnChainToken.all
  end

  # GET /on_chain_tokens/1 or /on_chain_tokens/1.json
  def show; end

  # GET /on_chain_tokens/new
  def new
    @on_chain_token = OnChainToken.new
  end

  # GET /on_chain_tokens/1/edit
  def edit; end

  # POST /on_chain_tokens or /on_chain_tokens.json
  def create
    @on_chain_token = OnChainToken.new(on_chain_token_params)

    respond_to do |format|
      if @on_chain_token.save
        format.html do
          redirect_to on_chain_token_url(@on_chain_token), notice: 'On chain token was successfully created.'
        end
        format.json { render :show, status: :created, location: @on_chain_token }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @on_chain_token.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /on_chain_tokens/1 or /on_chain_tokens/1.json
  def update
    respond_to do |format|
      if @on_chain_token.update(on_chain_token_params)
        format.html do
          redirect_to on_chain_token_url(@on_chain_token), notice: 'On chain token was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @on_chain_token }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @on_chain_token.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /on_chain_tokens/1 or /on_chain_tokens/1.json
  def destroy
    @on_chain_token.destroy

    respond_to do |format|
      format.html { redirect_to on_chain_tokens_url, notice: 'On chain token was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_on_chain_token
    @on_chain_token = OnChainToken.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def on_chain_token_params
    params.require(:on_chain_token).permit(:name, :token_id, :chain_id)
  end
end
