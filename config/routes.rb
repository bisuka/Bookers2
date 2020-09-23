Rails.application.routes.draw do

  get 'book_comments/create'
  get 'book_comments/destroy'
  # get 'home/about'
  devise_for :users
  root 'books#top'
  get 'home/about' => 'home#about'

  resources :users, only: [:index, :show, :edit, :update]

  # いいねとコメントは本に対して付くので、親子関係でbookの中に記述
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    # book_favorites_path  /books/:book_id/favorites
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create]
  end
    resources :book_comments, only: [:destroy]
end
