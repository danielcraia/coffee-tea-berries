Rails.application.routes.draw do
  resources :carts
  resources :products, only: :index
  resources :cart_products, only: %w[create update destroy]

  root to: "carts#index"
end
