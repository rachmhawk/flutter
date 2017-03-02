class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  include SessionsHelper

  def current_user
    return User.find_by(id: session[:user_id])
  end

  def login_required
    if !current_user
      redirect_to login_path, notice: 'login required'
    end
  end
end
