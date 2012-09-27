BirdWatching::Application.routes.draw do

  root :to => 'welcome#index'

  resources :bird_sightings, :only => [:create, :show, :index]

end
