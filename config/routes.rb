Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  root to: "home#top"
  get "home/about" => "home#about"

end