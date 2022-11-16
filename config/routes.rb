Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  # Defines the root path route ("/")
  root to: "flats#index"
  get '/dashboard', to: 'pages#dashboard'

  resources :flats do
    resources :bookings, only: :create do
      resources :payments, only: :new
    end
  end
end
