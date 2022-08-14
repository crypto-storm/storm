# frozen_string_literal: true

FactoryBot.define do
  factory :transaction_datum do
    amount { Faker::Number.number(digits: 3) }
    rate { Faker::Number.decimal(l_digits: 2) }

    association :location, factory: :chain
    association :token

    trait :out do
      association :out, factory: :transaction
    end

    trait :in do
      association :in, factory: :transaction
    end
  end
end
