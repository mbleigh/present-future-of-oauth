class UsersController < ApplicationController
  respond_to :html, :json
  
  def new
    respond_with (@user ||= User.new)
  end
  
  def show
    respond_with current_user
  end
  
  def create
    if User.create(params[:user])
      redirect_to '/'
    else
      flash[:error] = 'Unable to create user.'
      redirect_to :back
    end
  end
end
