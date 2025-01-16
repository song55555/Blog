class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_by(email: params[:user][:email])
      if user&.valid_password?(params[:user][:password])
        render json: { user: user.as_json, success: true }, status: :ok
      else
        render json: { error: 'Invalid email or password', success: false }, status: :unauthorized
      end
  end

  def destroy
      super do |user|
          if request.format.json?
              render json: { message: 'Logged out successfully', success: true }, status: :ok and return
          end
     end
     render json: { error: '로그아웃에 실패했습니다.', success: false }, status: :unprocessable_entity
  end
end