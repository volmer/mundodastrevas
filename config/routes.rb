Mundodastrevas::Application.routes.draw do
  resource :search, only: [:show]
  resources :pages, only: [:show]

  root 'home#index'

  get 'disqus' => 'posts#disqus'

  resources :zines, only: [:index, :show] do
    resources :posts, only: [:show]
  end

  resources :forums, only: [:show, :index] do
    resources :topics, only: [:show]
  end
end
