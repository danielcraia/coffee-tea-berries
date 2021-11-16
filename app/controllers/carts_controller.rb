# frozen_string_literal: true

class CartsController < ApplicationController
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
      render :new
    end
  end

  def destroy
    if @cart.destroy
      redirect_to carts_url
    else
      flash.now[:messages] = "Cart could not be destroyed!"
      redirect_to carts_url
    end
  end

  private

  def load_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.require(:cart).permit(:name)
  end
end
