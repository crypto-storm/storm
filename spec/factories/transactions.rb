# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    association :portfolio
    date { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }

    trait :trade do
      transient do
        token_in { build(:token) }
        token_out { build(:token) }
        location { build(:chain) }
        amount { Faker::Number.number(digits: 3) }
        rate { Faker::Number.decimal(l_digits: 2) }
      end

      tx_in { build(:transaction_datum, token: token_in, location:, amount:, rate:) }
      tx_out { build(:transaction_datum, token: token_out, location:, amount:, rate:) }

      after(:create) do |trade|
        trade.tx_in.save!
        trade.tx_out.save!
      end
    end

    trait :purchase do
      transient do
        token { build(:token) }
        location { build(:chain) }
        amount { Faker::Number.number(digits: 3) }
        rate { Faker::Number.decimal(l_digits: 2) }
      end

      tx_in { build(:transaction_datum, token:, location:, amount:, rate:) }

      after(:create) do |purchase|
        purchase.tx_in.save!
      end
    end

    trait :sale do
      transient do
        token { build(:token) }
        location { build(:chain) }
        amount { Faker::Number.number(digits: 3) }
        rate { Faker::Number.decimal(l_digits: 2) }
      end

      tx_out { build(:transaction_datum, token:, location:, amount:, rate:) }

      after(:create) do |sale|
        sale.tx_out.save!
      end
    end
  end
end
