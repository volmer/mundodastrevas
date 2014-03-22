Mundodastrevas::Application.routes.draw do
  mount Raddar::Engine => '/'

  resources :universes, only: [:show]

  # Redirect old URLs to the new ones
  get '/pubs/:id', to: redirect('/zines/%{id}')
  get '/pubs/:zine_id/stuffs/:id', to: redirect('/zines/%{zine_id}/posts/%{id}')
  #get '/forums/:forum_id/topics/:id', to: redirect('/forums/%{forum_id}')
  #get '/tags/:id', to: redirect {|params, _| "/tags/#{params[:id].gsub('-', ' ')}" }
end
