module Api
  module V1
    class SessionsController < Devise::SessionsController
      skip_before_action :verify_authenticity_token

      resource_description do
        short 'User Sessions Management'
        description 'API for managing user sessions, including login and authentication.'
      end

      api :POST, '/api/v1/sign_in', 'User sign in'
      param :email, String, desc: 'Email of the user', required: true
      param :password, String, desc: 'Password of the user', required: true
      def create
        user_exists = User.find_by(email: params[:email])
        resource = User.find_for_database_authentication(email: params[:email])
        if user_exists.present?
          if !params[:access_token]
            if user_exists && !resource
              return disabled_login_attempt
            elsif !resource
              return user_not_exist
            end
          end

          if params[:access_token]
            user = User.create_new_user_build(params)
            if user.save
              @user = user
              render 'api/v1/users/show'
            else
              user_not_exist
            end
          elsif resource.valid_password?(params[:password])
            @user = resource
            @user.touch
            render json: { message: 'User Signed In.', user: @user }, success: true, status: 200
          else
            invalid_login_attempt
          end
        else
          render json: { message: 'Something went wrong, Please contact support' }, success: false, status: 401
        end
      end

    end
  end
end
