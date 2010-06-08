Oauth2Provider::Application.routes.draw do |map|
  root :to => 'clients#index'
  
  devise_for :users

  resources :clients
  resources :users
  
  get 'oauth/authorize', :to => 'connections#authorize'
  post 'oauth/confirm', :to => 'connections#confirm'
  post 'oauth/access_token', :to => 'connections#access_token'
  
  get '/api/v2/json/user/show', :to => 'users#show', :format => 'json'
end
