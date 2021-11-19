# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::CartProductsController, type: :controller do
  describe "create" do
    subject(:create_cart_product) do
      post :create, params: params
    end

    let(:cart) { FactoryBot.create(:cart) }
    let(:product) { FactoryBot.create(:product) }

    context "with valid params" do
      let(:params) do
        {
          cart_product: {
            cart_id: cart.id,
            product_id: product.id,
            quantity: 3
          }
        }
      end

      it "creates a new cart product" do
        expect { create_cart_product }.to change(CartProduct, :count).by(1)
      end

      it "sets quantity to given quntity" do
        create_cart_product
        cart_product = CartProduct.find_by(cart_id: cart.id, product_id: product.id)
        expect(cart_product.quantity).to eq 3
      end

      it "redirects to the edit cart url" do
        create_cart_product
        expect(response).to redirect_to edit_cart_url(cart.id)
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          cart_product: {
            cart_id: cart.id,
            quantity: 3
          }
        }
      end

      it "does not change the cart products count" do
        expect { create_cart_product }.not_to change(CartProduct, :count)
      end

      it "redirects to edit cart url" do
        create_cart_product
        expect(response).to redirect_to edit_cart_url(cart.id)
      end

      it "flashes error message" do
        create_cart_product
        expect(flash[:messages]).to eq(["Product must exist"])
      end
    end
  end

  describe "update" do
    subject(:update_cart_product) do
      put :update, params: params
    end

    let(:cart_product) { FactoryBot.create(:cart_product) }

    context "with valid params" do
      let(:params) do
        {
          id: cart_product.id,
          cart_product: {
            quantity: cart_product.quantity + 2
          }
        }
      end

      it "updates the requested cart product" do
        update_cart_product
        expect(cart_product.reload.quantity).to eq cart_product.quantity
      end

      it "redirects to the edit cart url" do
        update_cart_product
        expect(response).to redirect_to edit_cart_url(cart_product.cart_id)
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          id: cart_product.id,
          cart_product: {
            quantity: -1
          }
        }
      end

      it "does not update the cart product" do
        update_cart_product
        expect(cart_product.reload.quantity).to be_positive
      end

      it "redirects to the edit cart url" do
        update_cart_product
        expect(response).to redirect_to edit_cart_url(cart_product.cart_id)
      end

      it "flashes error message" do
        update_cart_product
        expect(flash[:messages]).to eq(["Quantity must be greater than 0"])
      end
    end
  end

  describe "destroy" do
    subject(:destroy_cart_product) do
      delete :destroy, params: { id: cart_product.id }
    end

    let!(:cart_product) { FactoryBot.create(:cart_product) }

    context "when succesful" do
      it "destroys the requested cart" do
        expect { destroy_cart_product }.to change(CartProduct, :count).by(-1)
      end

      it "redirects to the edit cart url" do
        destroy_cart_product
        expect(response).to redirect_to edit_cart_url(cart_product.cart_id)
      end
    end

    context "when it fails" do
      before do
        allow(CartProduct).to receive(:find).and_return(cart_product)
        allow(cart_product).to receive(:destroy).and_return(false)
      end

      it "does not destroy the cart" do
        expect { destroy_cart_product }.not_to change(CartProduct, :count)
      end

      it "redirects to the edit cart url" do
        destroy_cart_product
        expect(response).to redirect_to edit_cart_url(cart_product.cart_id)
      end

      it "flashes error message" do
        destroy_cart_product
        expect(flash[:messages]).to eq("Product could not be removed!")
      end
    end
  end
end
