# frozen_string_literal: true

module OverviewHelper
  def round_if_bigger_than_one(number)
    return if number.nil?

    number.round >= 1 ? number.round(4) : number
  end
end
