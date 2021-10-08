Rails.application.routes.draw do


 

  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  root to: "homes#top"

  get "home/about" => "homes#about", as: "about"

  get "search" => "searches#search"

  resources :tweets do
    resource :favorites, only: [:create, :destroy]
  end

  resources :users
end
