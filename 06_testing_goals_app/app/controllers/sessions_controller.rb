class SessionsController < ApplicationController
  before_action :require_user!, only: [:destroy]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])
  
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Email/Password combo incorrect."]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end