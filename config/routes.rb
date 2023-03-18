Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/products/show', to: 'products#show_product', as: 'show_product'
  root to: "home#index"
end
