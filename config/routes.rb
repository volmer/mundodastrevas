Mundodastrevas::Application.routes.draw do
  resource :search, only: [:show]
  resources :pages, only: [:show]

  root 'home#index'

  resources :zines, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  resources :forums, only: [:show, :index] do
    resources :topics, only: [:show]
  end
end
