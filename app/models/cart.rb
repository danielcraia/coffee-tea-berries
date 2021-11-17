# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  validates :name, presence: true

  def total_price
    cart_products.map(&:total_price).sum.round(2)
  end
end
