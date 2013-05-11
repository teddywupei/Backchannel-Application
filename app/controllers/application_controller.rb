class ApplicationController < ActionController::Base

  protect_from_forgery

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to new_session_url
    end
  end

  def create
  end
end
