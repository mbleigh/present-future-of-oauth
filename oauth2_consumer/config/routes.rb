Oauth2Consumer::Application.routes.draw do |map|
  root :to => 'oauth#hello'
  
  resource :oauth, :controller => 'oauth' do    
    get :start
    get :callback
  end
end
