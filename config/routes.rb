Rails.application.routes.draw do
  root "lists#index"  

  resources :lists, only: [:index, :show, :new, :create, :destroy] do
    resources :bookmarks, only: [:new, :create]
  end

  resources :bookmarks, only: :destroy
  resources :movies, only: :index
end
