# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cart, type: :model do
  subject(:cart) { described_class.new(name: "Cart name") }

  it "is valid with a name" do
    expect(cart).to be_valid
  end

  it "is not valid without a name" do
    cart.name = nil
    expect(cart).not_to be_valid
  end
end
