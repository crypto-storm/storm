# frozen_string_literal: true

class ChartsController < ApplicationController
  def create
    evolution = BuildEvolution.call

    type_to_key = {
      '24H' => :weekly,
      '7D' => :weekly,
      '1M' => :monthly,
      '3M' => :tri_monthly,
      '1Y' => :yearly_by_day
    }

    @type = chart_params
    @evolution = evolution[type_to_key[@type]]

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def chart_params
    params.require(:type)
  end
end
