class ApiController < ActionController::Base
  before_action :authenticate

  respond_to :json

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      # User is signed in, but doesn't have permission to access the resource
      render json: { success: false, message: 'Unauthorized.' }, status: 401
    else
      # User is not signed in
      render json: { success: false, message: 'Please Sign In to continue.' }, status: 401
    end
  end

  private

  def authenticate
    if request.headers['Authorization'].present?
      @current_user = User.find_by_authentication_token(request.headers['Authorization'].split(' ').last)
      if @current_user
        @current_user.touch
      else
        render json: { success: false, message: 'Invalid Authentication Token.' }, status: 401
      end
    else
      render json: { success: false, message: 'No Authentication Token.' }, status: 401
    end
  end

end
