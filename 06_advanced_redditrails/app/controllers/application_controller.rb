class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  def login!(user)
    user.reset_session_token
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def current_user
    user = User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def require_user!
    unless current_user
      redirect_to new_session_url
    end
  end

  def require_moderator!
    sub = Sub.find_by(id: params[:id])
    mod = Sub.find_by(id: params[:id]).mod

    unless current_user == mod
      redirect_to sub_url(sub)
    end
  end
end
