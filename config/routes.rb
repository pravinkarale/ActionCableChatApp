Rails.application.routes.draw do
  get 'chat_rooms/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :chat_rooms, only: [:new, :create, :show, :index] do
  	post :create_message, on: :member
  end
  root 'chat_rooms#index'
  mount ActionCable.server => '/cable'
end
