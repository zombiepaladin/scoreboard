class SessionsController < ApplicationController
  def create
    @user = User.from_auth(auth_hash)
    @user.daily_pings.create(date: Date.today) unless @user.admin?
    session[:user_id] = @user.id
    redirect_to request.env['omniauth.origin'] || '/', notice: "You have logged in successfully. Ready Player One?"
  end
  
  def destroy
    reset_session
  end
  
  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end