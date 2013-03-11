if Competition.config.engine_routing
  Competition::Engine.routes.draw do
    root       :to => 'competition#index',  :as => 'competition'

    match '/:slug' => 'competition#new',    :as => 'competition_new',    :via => [:get]
    match '/:slug' => 'competition#create', :as => 'competition_create', :via => [:post]

    resources :items
  end
end
