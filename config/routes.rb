Rails.application.routes.draw do
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, shallow: true do
    resources :lists do
      resources :expenses
    end
  end
end
