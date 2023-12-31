Rails.application.routes.draw do
  devise_for :users
  root 'movies#index'
  resources :movies, only: [:index, :show] do
    member do
      post 'add_to_watchlist'
      delete 'remove_from_watchlist'
    end
  end
  get '/watchlist', to: 'movies#watchlist', as: 'watchlist'
  get '/search', to: 'movies#search'
  get '/popular', to: 'movies#popular'
  resources :watched_movies do
    post 'create_review', on: :member
  end
  get 'movies/:id/add_to_watched_movies', to: 'movies#add_to_watched_movies', as: 'add_to_watched_movies'
end
