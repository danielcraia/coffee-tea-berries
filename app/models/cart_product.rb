# frozen_string_literal: true

class CartProduct < ActiveRecord
  belongs_to :cart
  belongs_to :product
end
