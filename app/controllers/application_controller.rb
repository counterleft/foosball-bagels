# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def require_sign_in
    # carry a sign in error if it exists (due to over redirecting)
    flash[:error] = flash[:error]
    redirect_to sign_in_url unless signed_in?
  end

  private

  def current_user
    @current_user ||= session[:signed_in]
  end

  def signed_in?
    !!current_user
  end
end
