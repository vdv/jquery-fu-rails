JqueryFuRails::Engine.routes.draw do
  resources :uploads, :only => [ :index, :create, :destroy ]
end
