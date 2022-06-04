# frozen_string_literal: true

module PolymorphicSelect
  extend ActiveSupport::Concern

  def id_with_type
    "#{id}-#{self.class}"
  end
end
