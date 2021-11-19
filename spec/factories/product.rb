# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Name.name_with_middle }
    price { Faker::Number.number(digits: 3) }
    product_code { SecureRandom.uuid }
  end
end
