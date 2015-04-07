Rails.application.routes.draw do
  get 'jobs/new'

  root to: "welcome#index"
  resources :sessions
  resources :users
  resources :jobs

  get '/auth/twitter/callback', to: "sessions#create"
  get '/logout', to: 'sessions#destroy'

  post '/search' => 'search#search'
  
end
