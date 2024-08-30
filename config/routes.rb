# frozen_string_literal: true
Rails.application.routes.draw do

  resources :questions, only: [:index, :create]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :itineraries do
    get :run, on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
