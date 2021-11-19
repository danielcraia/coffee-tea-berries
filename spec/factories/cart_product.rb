# frozen_string_literal: true

FactoryBot.define do
  factory :cart_product do
    cart { FactoryBot.create(:cart) }
    product { FactoryBot.create(:product) }
    quantity { Faker::Number.number(digits: 2) }
  end
end
