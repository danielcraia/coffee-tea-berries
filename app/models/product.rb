# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  has_many :carts, through: :cart_products

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }

  def price_in_euros
    price.to_f / 100
  end
end
