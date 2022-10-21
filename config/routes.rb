Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "flats#index"

  resources :flats do
    resources :bookings, only: [:create]
  end
end
