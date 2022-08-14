# frozen_string_literal: true

FactoryBot.define do
  factory :historic_rate do
    date { Faker::Date.between(from: '2019-09-23', to: '2022-09-25') }
    rate { Faker::Number.decimal(l_digits: 2) }
    association :token
  end
end
