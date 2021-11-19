# frozen_string_literal: true

require "rails_helper"

RSpec.describe CartProduct, type: :model do
  subject(:cart_product) { described_class.new(cart: cart, product: product) }

  let(:cart) { FactoryBot.create(:cart) }
  let(:product) { FactoryBot.create(:product) }

  it "is valid with valid attributes" do
    expect(cart_product).to be_valid
  end

  it "is not valid without a cart" do
    cart_product.cart = nil
    expect(cart_product).not_to be_valid
  end

  it "is not valid without a product" do
    cart_product.product = nil
    expect(cart_product).not_to be_valid
  end

  it "is not valid with a negative quantity" do
    cart_product.quantity = -2
    expect(cart_product).not_to be_valid
  end

  it "is not valid with a float as quantity" do
    cart_product.quantity = 2.5
    expect(cart_product).not_to be_valid
  end

  describe "total_price" do
    context "with a regular product" do
      it "multiplies the prcie by quantity" do
        cart_product.quantity = 3
        cart_product.save

        expect((cart_product.quantity * cart_product.product.price).to_f / 100).to eq(
          cart_product.total_price
        )
      end
    end

    context "with coffee as a product" do
      let(:product) { FactoryBot.create(:product, :coffee) }
      let(:discount_rules) { Settings.discounts.cf1 }
      let(:discounted_price) do
        new_price = cart_product.quantity * cart_product.product.price * discount_rules.price_factor
        (new_price / 100).round(2)
      end

      it "applies the discount rule" do
        cart_product.quantity = discount_rules.threshold
        cart_product.save

        expect(discounted_price).to eq cart_product.total_price
      end
    end

    context "with green tea as a product" do
      let(:product) { FactoryBot.create(:product, :green_tea) }
      let(:discount_rules) { Settings.discounts.gr1 }
      let(:discounted_price) do
        discounted = cart_product.quantity / discount_rules.step * product.price
        full_price = cart_product.quantity % discount_rules.step * product.price
        ((discounted + full_price).to_f / 100).round(2)
      end

      it "applies the discount rule" do
        cart_product.quantity = discount_rules.step * 2 + 1
        cart_product.save

        expect(discounted_price).to eq cart_product.total_price
      end
    end

    context "with strawberries as a product" do
      let(:product) { FactoryBot.create(:product, :strawberries) }
      let(:discount_rules) { Settings.discounts.sr1 }
      let(:discounted_price) do
        (cart_product.quantity * discount_rules.price.to_f / 100).round(2)
      end

      it "applies the discount rule" do
        cart_product.quantity = discount_rules.threshold + 1
        cart_product.save

        expect(discounted_price).to eq cart_product.total_price
      end
    end
  end
end
