# frozen_string_literal: true

FactoryBot.define do
  factory :portfolio do
    name { Faker::Name.name }
  end
end
