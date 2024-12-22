Rails.application.routes.draw do
  devise_for :users
  get "/hello", to: "hello#index"
  resources :posts, only: [:index, :show]
end