Mundodastrevas::Application.routes.draw do
  mount Raddar::Engine => '/'

  resources :universes, only: [:show]

  # Redirect old URLs to the new ones
  get '/pubs/:id', to: redirect('/zines/%{id}')
  get '/pubs/:zine_id/stuffs/:id', to: redirect('/zines/%{zine_id}/posts/%{id}')

  resources :posts, path: '/feed', only: [:index], defaults: { format: 'atom' }

  resources :zines do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
    end

    resources :followerships, only: [:create, :destroy], on: :member, controller: 'zine_followerships'
    get 'followers', controller: 'zine_followerships'
  end

  resources :users, only: [] do
    resources :zines, only: [:index]
  end

  resources :forums, only: [:show, :index] do
    resources :topics, except: [:index] do
      resources :forum_posts, only: [:create, :update, :destroy]
    end

    resources :followerships, only: [:create, :destroy], on: :member, controller: 'forum_followerships'
    get 'followers', controller: 'forum_followerships'
  end

  Raddar::Engine.routes.draw do
    namespace :admin do
      resources :zines, only: [:index, :edit, :update], controller: 'zines'
      resources :forums, except: [:show], controller: 'forums'
    end
  end
end
