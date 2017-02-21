Mundodastrevas::Application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :reviews, only: [:create, :update]
  resources :tags, only: [:show]
  resource :search, only: [:show]
  resources :pages, only: [:show]
  resources :contacts, only: [:new, :create]

  devise_for :users,
             controllers: {
               registrations: 'users/registrations',
               sessions: 'users/sessions',
               passwords: 'users/passwords',
               confirmations: 'users/confirmations'
             },
             module: :devise

  as :user do
    get '/users/password/change' => 'users/passwords#change',
        as: :change_user_password
    patch '/users/password/change' => 'users/passwords#do_change',
          as: :do_change_user_password
    get '/users/registrations/destroy' => 'users/registrations#destroy',
        as: :destroy_user_registration
  end

  root 'home#index'

  resource :user, only: [:show]

  resources :universes, only: [:show]

  # Redirect old URLs to the new ones
  get '/pubs/:id', to: redirect('/zines/%{id}')
  get '/pubs/:zine_id/stuffs/:id', to: redirect('/zines/%{zine_id}/posts/%{id}')

  resources :posts, path: '/feed', only: [:index], defaults: { format: 'atom' }

  resources :zines do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
    end
  end

  resources :users, only: [] do
    resources :zines, only: [:index]
  end

  resources :forums, only: [:show, :index] do
    resources :topics, except: [:index] do
      resources :forum_posts, only: [:create, :update, :destroy]
    end
  end
end
