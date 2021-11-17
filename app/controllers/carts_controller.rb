# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :load_cart, only: %w[destroy]

  def index
    @carts = Cart.all
  end

  def new
    @cart = Cart.new
  end

  def create
    cart = Cart.new(cart_params)

    if cart.save
      redirect_to carts_url
    else
      flash.now[:messages] = cart.errors.full_messages
      redirect_to new_cart_url
    end
  end

  def edit
    @cart = Cart.includes(:cart_products, :products).find(params[:id])
    @products = Product.all
  end

  def destroy
    flash.now[:messages] = "Cart could not be destroyed!" unless @cart.destroy

    redirect_to carts_url
  end

  private

  def load_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.require(:cart).permit(:name)
  end
end
