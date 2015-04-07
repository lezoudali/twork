Rails.application.routes.draw do
  get 'jobs/new'

  root to: "welcome#index"
  resources :sessions
  resources :jobs

  get '/auth/twitter/callback', to: "sessions#create"
  get '/logout', to: 'sessions#destroy'
  
end
