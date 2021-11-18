# frozen_string_literal: true

class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    (discounted_price.to_f / 100).round(2)
  end

  private

  def discounted_price
    return product.price unless quantity >= discount_threshold

    if settings_step
      discounted = quantity / settings_step * product.price
      full_price = quantity % settings_step * product.price

      discounted + full_price
    elsif settings_price
      quantity * settings_price
    elsif settings_factor
      quantity * 2 / 3 * product.price
    end
  end

  def product_discounts
    discount_config[product.product_code.downcase]
  end

  def discount_threshold
    product_discounts.threshold || 1
  end

  def settings_step
    product_discounts.step
  end

  def settings_price
    product_discounts.price
  end

  def settings_factor
    product_discounts.price_factor
  end

  def discount_config
    Settings.discounts.to_h.with_indifferent_access
  end
end
