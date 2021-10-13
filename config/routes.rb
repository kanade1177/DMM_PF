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
    #試してるやつ
    # member do
    #   get :following, :followers
    # end
    #元々のやつ
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    delete :followers, on: :member

   end
  resources :relationships, only: [:create, :destroy]


  resources :notifications, only: [:index, :destroy]





end
