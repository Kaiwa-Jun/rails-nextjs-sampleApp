Rails.application.routes.draw do
  devise_for :users
  get "/hello", to: "hello#index"
  resources :posts, only: [:index, :show, :create, :update]
  scope :api do
    post '/signup', to: 'registrations#create'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
end