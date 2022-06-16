# frozen_string_literal: true

class TokensController < ApplicationController
  before_action :set_token, only: %i[show edit update destroy]

  def index
    @tokens = Token.includes(logo_attachment: :blob).order(:created_at)
  end

  def show; end

  def new
    @token = Token.new
  end

  def edit; end

  def create
    @token = Token.new(token_params)

    respond_to do |format|
      if @token.save
        format.html { redirect_to token_url(@token), notice: 'Token was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @token.update(token_params)
        format.turbo_stream
        format.html { redirect_to token_url(@token), notice: 'Token was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @token.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tokens_url, notice: 'Token was successfully destroyed.' }
    end
  end

  private

  def set_token
    @token = Token.find(params[:id])
  end

  def token_params
    params.require(:token).permit(:name, :abbr, :logo)
  end
end
