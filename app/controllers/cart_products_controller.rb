# frozen_string_literal: true

class CartProductsController < ApplicationController
  before_action :initialize_cart_product, only: :create
  before_action :load_cart_product, only: %w[destroy update]

  def create
    @cart_product.reset_quantity unless @cart_product.id
    @cart_product.quantity += create_params[:quantity].to_i

    flash.now[:messages] = @cart_product.errors.full_messages unless @cart_product.save

    redirect_to edit_cart_url(create_params[:cart_id])
  end

  def update
    flash.now[:messages] = @cart_product.errors.full_messages unless @cart_product.update(
      quantity: update_params[:quantity]
    )

    redirect_to edit_cart_url(@cart_product.cart_id)
  end

  def destroy
    flash.now[:messages] = "Product could not be removed!" unless @cart_product.destroy

    redirect_to edit_cart_url(@cart_product.cart_id)
  end

  private

  def initialize_cart_product
    @cart_product = CartProduct.find_or_initialize_by(create_params.slice(:cart_id, :product_id))
  end

  def load_cart_product
    @cart_product = CartProduct.find(params[:id])
  end

  def create_params
    params.require(:cart_product).permit(:cart_id, :product_id, :quantity)
  end

  def update_params
    params.require(:cart_product).permit(:quantity)
  end
end
