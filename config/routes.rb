Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/logout', to: 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/products/show', to: 'products#show_product', as: 'show_product'
  post '/products/purchase', to: 'products#purchase_product', as: 'purchase_product'
  root to: "home#index"
end
