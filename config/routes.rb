Rails.application.routes.draw do

  root 'chats#index'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create]
end
