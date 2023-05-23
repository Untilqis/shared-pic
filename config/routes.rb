Rails.application.routes.draw do
  devise_for :users
  root to: "albums#index"
  get '/album/tag/:name', to: "albums#tag"
  resources :users, only: [:show, :edit, :update]
  resources :albums do
    resources :comments, only: :create
  end
end
