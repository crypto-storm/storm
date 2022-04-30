# frozen_string_literal: true

module OverviewHelper
  def round_if_bigger_than_one(number)
    number >= 1 ? number.round(3) : number
  end
end
