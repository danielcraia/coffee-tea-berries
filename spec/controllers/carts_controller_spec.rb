# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::CartsController, type: :controller do
  describe "index" do
    let!(:carts) { FactoryBot.create_list(:cart, 3) }

    before do
      get :index
    end

    it "assigns @carts" do
      expect(assigns(:carts)).to eq(carts)
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end

  describe "new" do
    before do
      get :new
    end

    it "assigns a new cart as @cart" do
      expect(assigns(:cart)).to be_a_new(Cart)
    end

    it "render the new template" do
      expect(response).to render_template("new")
    end
  end

  describe "create" do
    subject(:create_cart) do
      post :create, params: params
    end

    context "with valid params" do
      let(:params) do
        { cart: { name: "MyCart" } }
      end

      it "creates a new cart" do
        expect { create_cart }.to change(Cart, :count).by(1)
      end

      it "redirects to the carts index" do
        create_cart
        expect(response).to redirect_to carts_url
      end
    end

    context "with invalid params" do
      let(:params) do
        { cart: { name: "" } }
      end

      it "does not change the Cart count" do
        expect { create_cart }.not_to change(Cart, :count)
      end

      it "redirects to new cart url" do
        create_cart
        expect(response).to redirect_to new_cart_url
      end

      it "flashes error message" do
        create_cart
        expect(flash[:messages]).to eq(["Name can't be blank"])
      end
    end
  end

  describe "edit" do
    let!(:cart) { FactoryBot.create(:cart) }
    let!(:products) { FactoryBot.create_list(:product, 3) }

    before do
      get :edit, params: { id: cart.id }
    end

    it "assigns @cart" do
      expect(assigns(:cart)).to eq(cart)
    end

    it "assigns @products" do
      expect(assigns(:products)).to eq(products)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end

  describe "destroy" do
    subject(:destroy_cart) do
      delete :destroy, params: { id: cart.id }
    end

    let!(:cart) { FactoryBot.create(:cart) }

    context "when succesful" do
      it "destroys the requested cart" do
        expect { destroy_cart }.to change(Cart, :count).by(-1)
      end

      it "redirects to the carts index" do
        destroy_cart
        expect(response).to redirect_to carts_url
      end
    end

    context "when it fails" do
      before do
        allow(Cart).to receive(:find).and_return(cart)
        allow(cart).to receive(:destroy).and_return(false)
      end

      it "does not destroy the cart" do
        expect { destroy_cart }.not_to change(Cart, :count)
      end

      it "redirects to the carts index" do
        destroy_cart
        expect(response).to redirect_to carts_url
      end

      it "flashes error message" do
        destroy_cart
        expect(flash[:messages]).to eq("Cart could not be destroyed!")
      end
    end
  end
end
