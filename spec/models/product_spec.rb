# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  subject(:product) { described_class.new(name: "Coffee", price: 50) }

  it "is valid with valid attributes" do
    expect(product).to be_valid
  end

  it "is not valid without a name" do
    product.name = nil
    expect(product).not_to be_valid
  end

  it "is not valid without a price" do
    product.price = nil
    expect(product).not_to be_valid
  end

  it "is not valid with a negative price" do
    product.price = -2
    expect(product).not_to be_valid
  end

  it "is not valid with a a float as price" do
    product.price = 2.5
    expect(product).not_to be_valid
  end
end
