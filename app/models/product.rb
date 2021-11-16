# frozen_string_literal: true

class Product < ActiveRecord
  has_many :cart_products, dependent: :destroy
  has_many :carts, through: :cart_products

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
end
