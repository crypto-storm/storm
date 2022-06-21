# frozen_string_literal: true

FactoryBot.define do
  factory :chain do
    name { Faker::Name.name }
    logo { Rack::Test::UploadedFile.new('spec/fixtures/assets/image.jpg', 'image/jpeg') }
  end
end
