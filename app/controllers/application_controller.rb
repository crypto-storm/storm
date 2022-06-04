# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include PolymorphicLocation
  include CurrentPortfolio
end
