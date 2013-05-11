class SessionController < ApplicationController

def index
  redirect_to login_path
end

def create
  if user = User.authenticate(params[:name], params[:password])
    session[:user_id] = user.id
    session[:user_name] = params[:name]
    if User.find(user.id).admin_flag == 1
      redirect_to admin_url
    else
      redirect_to posts_path
    end
  else
    redirect_to login_path
  end
end

def destroy
  session[:user_id] = nil
  session[:user_name] = nil
  redirect_to new_session_path
end

end