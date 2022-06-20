# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    association :portfolio

    trait :trade do
      transient do
        token { build(:token) }
        location { build(:chain) }
        amount { Faker::Number.number(digits: 3) }
      end

      tx_in { build(:transaction_datum, token:, location:, amount:) }
      tx_out { build(:transaction_datum, token:, location:, amount:) }

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
