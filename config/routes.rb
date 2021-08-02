Rails.application.routes.draw do
  get '/login_status', to: 'sessions#status'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, shallow: true do
    resources :lists do
      resources :expenses
    end
  end
end
