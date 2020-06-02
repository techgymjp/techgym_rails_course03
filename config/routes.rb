Rails.application.routes.draw do
  root 'books#index'
  resources :books, only: [:index, :show, :destroy] do
    resource :progress, only: [:update], module: 'books'
  end
  namespace :books do
    resources :search, only: [:new, :create]
  end
end
