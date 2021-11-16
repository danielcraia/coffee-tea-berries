Rails.application.routes.draw do
  resources :carts
  resources :products, only: :index

  root to: "carts#index"
end
