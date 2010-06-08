class ConnectionsController < ApplicationController
  before_filter :login_required, :only => ['authorize', 'confirm']
  skip_before_filter :verify_authenticity_token, :only => 'access_token'
  
  def authorize
    raise "You must do web server because this is hacky." unless params[:type] == 'web_server'
  end
  
  def confirm
    redirect = params[:redirect_uri].blank? ? client.redirect_uri : params[:redirect_uri]
    verifier = Verifier.generate(client, current_user, redirect)
    redirect += "?code=#{verifier.code}"
    redirect += "&state=#{params[:state]}" if params[:state].present?
    redirect_to redirect
  end
  
  def access_token
    @verifier = Verifier.find_by_code(params[:code])
    @client = Client.find_by_key_and_secret(params[:client_id], params[:client_secret])
    
    render :text => "bad_verification_code", :status => 400 and Rails.logger.info('bad verification code') and return unless @verifier
    render :text => "incorrect_client_credentials", :status => 400 and Rails.logger.info('incorrect client credentials') and return unless @client && @client == @verifier.client
    render :text => "redirect_uri_mismatch", :status => 400 and Rails.logger.info('redirect uri mismatch') and return unless params[:redirect_uri].blank? || @verifier.redirect_uri == params[:redirect_uri]
    
    @token = AccessToken.generate(@verifier.client, @verifier.user)
    
    render :text => @token.to_form, :content_type => "application/x-www-form-urlencoded"
  end
  
  protected
  
  def client
    @client ||= Client.find_by_key(params[:client_id])
  end
  helper_method :client
end
