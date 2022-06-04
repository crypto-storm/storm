# frozen_string_literal: true

module PolymorphicLocation
  extend ActiveSupport::Concern

  private

  def adjust_location(permitted)
    id, type = permitted[:location].split('-')
    permitted[:location_id] = id
    permitted[:location_type] = type
    permitted[:location] = nil

    permitted
  end
end
