Rails.application.routes.draw do

  resources :skills, only: [:index, :show]

  root to: "welcome#index"
  resources :sessions
  resources :users
  resources :jobs do 
    resources :requests
  end

  get '/auth/twitter/callback', to: "sessions#create"
  get '/logout', to: 'sessions#destroy'

  post '/search' => 'search#search'

  patch '/requests/:id' => 'requests#update'
  
end
