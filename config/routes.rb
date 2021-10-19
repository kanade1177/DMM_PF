Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"

  get "home/about" => "homes#about", as: "about"

  get "search" => "searches#search"

  get "/tweets/category/:id" => "tweets#category"

  resources :tweets do
    #試し

    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users do
    #元々のやつ
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    delete :followers, on: :member
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'

   end
  # resources :relationships, only: [:create, :destroy] do
  # get 'followings' => 'relationships#followings', as: 'followings'
  # get 'followers' => 'relationships#followers', as: 'followers'
  # end

  resources :notifications, only: [:index, :destroy]





end
