class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:create, :index]

  def index
  end

  def create
     @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to "/dashboard/#{@user.id}"
    else 
      flash[:errors] = ["Invalid Combination"]
      redirect_to :back
    end
  end

  def destroy
  	reset_session
    redirect_to :root
  end
end
