ActionController::Routing::Routes.draw do |map|
  map.resources :sessions
  map.resources :pepinos
  map.resources :tomatoes
  map.resources :chards
  map.resources :terraces
  map.resources :crops
  map.resources :fertilizers
  map.resources :orchards
  map.resources :deliveries
  map.resources :flowers
  map.resources :users

  map.root :controller => "welcome"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
