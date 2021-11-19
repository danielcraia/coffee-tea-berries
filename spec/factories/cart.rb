# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    name { Faker::Name.name_with_middle }
  end
end
