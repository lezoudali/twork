Rails.application.routes.draw do

  resources :skills, only: [:index]

  root to: "welcome#index"
  resources :sessions
  resources :users do
    member do  
      get :jobs
    end
  end




  resources :jobs do 
    resources :requests
  end

  get '/auth/twitter/callback', to: "sessions#create"
  get '/logout', to: 'sessions#destroy'

  post '/search' => 'search#search'

  patch '/requests/:id' => 'requests#update'

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  
end
