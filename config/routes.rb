Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"

  get "home/about" => "homes#about", as: "about"

  get "search" => "searches#search"

  resources :tweets do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    #元々のやつ
    get :follows, on: :member
    delete :followers, on: :member

   end

  resources :notifications, only: [:index, :destroy]





end
