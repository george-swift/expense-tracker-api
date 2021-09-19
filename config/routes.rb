Rails.application.routes.draw do
  resource :sessions, only: %i[create destroy]
  resources :users, shallow: true do
    resources :lists do
      resources :expenses
    end
  end
end
