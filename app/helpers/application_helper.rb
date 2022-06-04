# frozen_string_literal: true

module ApplicationHelper
  def all_locations
    Chain.all + Exchange.all
  end
end
