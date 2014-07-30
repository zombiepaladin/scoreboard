class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def current_user
    User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def login_required
    # Change "cas" to your preferred provider
    redirect_to "/auth/cas?origin=#{request.env['ORIGINAL_FULLPATH']}", alert: "You must be logged in to access that page." unless signed_in?
  end
  
  def acceptance_required
    render "/rules/accept_terms_and_conditions" unless current_user.accepted_terms_and_conditions? || current_user.admin?
  end

  def admin_required
    redirect_to '/', alert: "Must be an administrator to access that page." unless current_user.try(:admin?)
  end

  helper_method :current_user, :signed_in?
end
