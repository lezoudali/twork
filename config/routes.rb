Rails.application.routes.draw do
  root to: "welcome#index"

  get '/auth/twitter/callback' => "users#create"

end
