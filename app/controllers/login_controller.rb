class LoginController < ApplicationController

  def login
    @user = User.new
    @user.name = params[:username]
  end

  def process_login
    if user = user.authenticate(params[:user])
      session[:id] = user.id
      redirect_to session[:return_to]|| _/_
    else
      flash[:error] = "Invalid login"
      redirect_to :action => login, :username => params[:user][:username]
    end
  end

  def logout
    reset_session
    flash[:message] = "logged out"
    redirect_to :action => login
  end


end