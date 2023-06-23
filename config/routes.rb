# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'orders#new'

  get '/new_dishes', to: 'dishes#new'
  post '/create_dishes', to: 'dishes#create'

  get '/new_orders', to: 'orders#new'
  get '/cooking_order', to: 'orders#cooking_order'
  post '/create_orders', to: 'orders#create'
end
