class Users::SessionsController < Devise::SessionsController
  def create
    user = User.find_by(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      token = JWT.encode({user_id: user.id}, Rails.application.credentials.secret_key_base)
      render json: { user: user, token: token, success: true }, status: :ok
    else
      render json: { error: 'Invalid email or password', success: false }, status: :unauthorized
    end
  end

  def destroy
      head :no_content
   end
end