Mundodastrevas::Application.routes.draw do
  mount Raddar::Engine => '/'

  resources :universes, only: [:show]
end
