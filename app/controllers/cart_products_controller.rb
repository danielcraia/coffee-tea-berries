# frozen_string_literal: true

class CartProductsController < ApplicationController
  before_action :initialize_cart_product

  def create
    @cart_product.quantity += create_params[:quantity].to_i

    flash.now[:messages] = cart.errors.full_messages unless @cart_product.save

    redirect_to edit_cart_url(create_params[:cart_id])
  end

  private

  def initialize_cart_product
    @cart_product = CartProduct.find_or_initialize_by(create_params.slice(:cart_id, :product_id))
  end

  def create_params
    params.require(:cart_product).permit(:cart_id, :product_id, :quantity)
  end
end
