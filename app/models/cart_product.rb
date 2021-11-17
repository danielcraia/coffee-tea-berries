# frozen_string_literal: true

class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    quantity * product.price_in_euros
  end
end
