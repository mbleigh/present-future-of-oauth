class OauthController < ApplicationController
  def start
    redirect_to client.web_server.authorize_url(
      :scope => 'user'
    )
  end

  def callback
    access_token = client.web_server.get_access_token(
      params[:code], :redirect_uri => callback_oauth_url(:format => 'json')
    )

    # you should save the access token here.
    
    render :json => access_token.get('/api/v2/json/user/show')
  end

  protected

  def client
    # @client ||= OAuth2::Client.new(
    #   '296e901b0e6ab74db167', '625fe65c7f74ee4a015d121efb011a45776d510d', 
    #   :site => 'https://github.com',
    #   :authorize_path => '/login/oauth/authorize', 
    #   :access_token_path => '/login/oauth/access_token'
    # )
    
    @client ||= OAuth2::Client.new(
      '5aca87e57282d7e106f3', 'af0b2016826fc24e2d9bba6cdd753003cf969483', 
      :site => 'http://localhost:3001'
    )
  end
end
