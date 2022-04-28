# frozen_string_literal: true

class BuildStats < ApplicationService
  def initialize(assets)
    @assets = assets
    @total_value = total_value
    @distribution = distribution
  end

  def call
    OpenStruct.new(
      total_value: @total_value,
      distribution: @distribution,
      rounded_distribution:
    )
  end

  private

  def total_value
    @total_value = @assets.values.reduce(0) do |acc, data|
      data.total ? acc + data.total : acc
    end.to_f
  end

  def distribution
    @distribution = @assets.map do |asset, data|
      percentage = data.total ? data.total.to_f / @total_value : 0
      [asset, percentage]
    end.to_h
  end

  def rounded_distribution(minimum = 0.1)
    rounded_distribution = Hash.new(0)

    @distribution.each do |asset, percentage|
      if percentage >= minimum
        rounded_distribution[asset] = percentage
      else
        rounded_distribution[:others] += percentage
      end
    end

    rounded_distribution
  end
end
