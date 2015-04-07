Rails.application.routes.draw do
  root to: "welcome#index"

  resources :sessions

  get '/auth/twitter/callback', to: "sessions#create"
  get '/logout', to: 'sessions#destroy'
  
end
