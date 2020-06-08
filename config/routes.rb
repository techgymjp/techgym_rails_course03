Rails.application.routes.draw do
  root 'books#index'
  namespace :books do
    resources :search, only: [:new, :create]
  end
  resources :books, only: [:index, :show, :destroy] do
    resource :progress, only: [:update], module: 'books'
  end
end
