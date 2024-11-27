class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      # User is signed in, but doesn't have permission to access the resource
      redirect_to root_path, alert: exception.message
    else
      # User is not signed in; redirect them to the sign-in page
      redirect_to new_user_session_path, alert: "Please sign in to continue."
    end
  end

end
