class SessionsController < ApplicationController
  #login
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      # login code
       session[:user_id] = @user.id

      #  redirect code
       redirect_to posts_url, notice: 'Login Successful!'
    else
      # wrong email/password
      render action: 'new' #text: 'login failed'

    end
  end

  #logout
  def destroy
    session[:user_id] = nil
  end
end
