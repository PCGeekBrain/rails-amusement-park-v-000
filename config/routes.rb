Rails.application.routes.draw do

  root 'application#homepage'

  get '/signin' => 'users#signin', as: 'sign_in'
  get '/signout' => 'users#destroy', as: 'sign_out'

  resources :users

  get '/attractions/:id/ride' => 'attractions#ride', as: 'ride_attraction'

  resources :attractions

end
