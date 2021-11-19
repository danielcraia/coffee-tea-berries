# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Name.name_with_middle }
    price { Faker::Number.number(digits: 3) }
    product_code { SecureRandom.uuid }

    trait :coffee do
      name { "Coffee" }
      product_code { "CF1" }
    end

    trait :green_tea do
      name { "Green tea" }
      product_code { "GR1" }
    end

    trait :strawberries do
      name { "Strawberries" }
      product_code { "SR1" }
    end
  end
end
