Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/logout', to: 'devise/sessions#destroy'
  end
  get '/products/show', to: 'products#show_product', as: 'show_product'
  post '/products/purchase', to: 'products#purchase_product', as: 'purchase_product'
  get '/cart', to: 'carts#index', as: 'cart'
  post "carts/add_product", to: "carts#add_product", as: "add_to_cart"
  get "carts/delete_product/:id", to: "carts#delete_product", as: "delete_from_cart"
  root to: "home#index"
end
