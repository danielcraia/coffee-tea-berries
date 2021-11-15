# frozen_string_literal: true

class Product < ActiveRecord
  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
end
