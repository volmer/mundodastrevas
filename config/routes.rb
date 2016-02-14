Mundodastrevas::Application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :watches, only: [:create, :update]
  resources :reviews, only: [:create, :update]
  resources :tags, only: [:show]
  resource :search, only: [:show]
  resources :pages, only: [:show]
  resources :contacts, only: [:new, :create]
  resources :messages, only: [:index]

  resources :notifications, only: [:index, :show] do
    patch 'read'
  end

  devise_for :users,
             controllers: {
               registrations: 'users/registrations',
               sessions: 'users/sessions',
               passwords: 'users/passwords',
               confirmations: 'users/confirmations',
               omniauth_callbacks: 'users/omniauth_callbacks'
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

  namespace 'users', as: 'user' do
    resource :privacy, only: [:edit, :update]
    resource :email_preferences, only: [:edit, :update]
    resources :external_accounts, only: [:index, :destroy]
  end

  resources :users, only: [:show] do
    resources :followerships, only: [:create, :destroy], on: :member
    get 'followers', controller: 'followerships'
    get 'following', controller: 'followerships'

    resources :messages, only: [:index, :create]
  end

  namespace :admin do
    root 'home#index'

    resources :users, only: [:index, :show, :update]
    resources :pages, except: [:show]
    resources :zines, only: [:index, :edit, :update], controller: 'zines'
    resources :forums, except: [:show], controller: 'forums'
  end

  resources :universes, only: [:show]

  # Redirect old URLs to the new ones
  get '/pubs/:id', to: redirect('/zines/%{id}')
  get '/pubs/:zine_id/stuffs/:id', to: redirect('/zines/%{zine_id}/posts/%{id}')

  resources :posts, path: '/feed', only: [:index], defaults: { format: 'atom' }

  resources :zines do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
    end

    resources(
      :followerships,
      only: [:create, :destroy],
      on: :member,
      controller: 'zine_followerships')
    get 'followers', controller: 'zine_followerships'
  end

  resources :users, only: [] do
    resources :zines, only: [:index]
  end

  resources :forums, only: [:show, :index] do
    resources :topics, except: [:index] do
      resources :forum_posts, only: [:create, :update, :destroy]
    end

    resources(
      :followerships,
      only: [:create, :destroy],
      on: :member,
      controller: 'forum_followerships')
    get 'followers', controller: 'forum_followerships'
  end
end
