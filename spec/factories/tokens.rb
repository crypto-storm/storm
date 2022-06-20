# frozen_string_literal: true

FactoryBot.define do
  factory :token do
    name { Faker::Name.name }
    abbr { Faker::Name.name }
    logo { Rack::Test::UploadedFile.new('spec/fixtures/assets/image.jpg', 'image/jpeg') }

    association :native_chain, factory: :chain
  end
end
