Rails.application.routes.draw do

  # get 'home/about'
  devise_for :users
  root 'books#top'
  get 'home/about' => 'home#about'

  # resources :posts
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]

end
