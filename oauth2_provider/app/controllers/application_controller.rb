class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  before_filter :login_via_oauth
  
  def login_required
    unless current_user
      session['return_to'] = request.url
      redirect_to '/users/sign_in'       
    end
  end
  
  def login_via_oauth
    if params[:access_token]
      @current_user = AccessToken.find_by_token(params[:access_token]).user
    end
  end
  
  def current_user
    @current_user || super
  end
end
