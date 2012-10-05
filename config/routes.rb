BirdWatching::Application.routes.draw do

  root :to => 'home#index'

  resources :bird_sightings
end
