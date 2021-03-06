Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :users,only: [:show,:index,:edit,:update]

  get "/users/:id/relationships/follow" => "relationships#follow_index", as: "follow"
  get "/users/:id/relationships/following" => "relationships#following_index", as: "following"

  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end

  root to: "home#top"
  get "home/about" => "home#about"

  resources :relationships, only: [:create, :destroy]

  get "/search" => "search#search", as: "search"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end