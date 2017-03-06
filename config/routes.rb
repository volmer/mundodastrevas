Mundodastrevas::Application.routes.draw do
  resource :search, only: [:show]
  resources :pages, only: [:show]

  root 'home#index'

  # Redirect old URLs to the new ones
  get '/pubs/:id', to: redirect('/zines/%{id}')
  get '/pubs/:zine_id/stuffs/:id', to: redirect('/zines/%{zine_id}/posts/%{id}')

  resources :posts, path: '/feed', only: [:index], defaults: { format: 'atom' }

  resources :zines, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  resources :forums, only: [:show, :index] do
    resources :topics, only: [:show]
  end
end
