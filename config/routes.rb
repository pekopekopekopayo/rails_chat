Rails.application.routes.draw do

  root 'chat_rooms#index'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create]
  resources :chat_rooms, only: [:index, :new, :create, :show] do
    resources :chats, only: [:index, :create]
  end
end
