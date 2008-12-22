ActionController::Routing::Routes.draw do |map|
  map.resources :pepinos

  map.resources :tomatoes

  map.resources :chards

  map.resources :terraces

  map.resources :crops

  map.resources :fertilizers

  map.resources :orchards

  map.root :controller => "welcome"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
