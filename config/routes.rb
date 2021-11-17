Rails.application.routes.draw do
  resources :carts
  resources :products, only: :index
  resources :cart_products, only: :create

  root to: "carts#index"
end
