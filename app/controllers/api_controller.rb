class ApiController < ActionController::Base
  before_action :authenticate

  respond_to :json

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
