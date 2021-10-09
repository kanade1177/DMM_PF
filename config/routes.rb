Rails.application.routes.draw do





  devise_for :users
  root to: "homes#top"

  get "home/about" => "homes#about", as: "about"

  get "search" => "searches#search"

  resources :tweets do
    resource :favorites, only: [:create, :destroy]
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    delete :followers, on: :member
  end
end
