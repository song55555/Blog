class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    if resource.save
        token = JWT.encode({ user_id: resource.id, exp: 1.day.from_now.to_i }, Rails.application.credentials.secret_key_base)
      render json: { user: resource.as_json, token: token, success: true }, status: :created
    else
      render json: { errors: resource.errors.full_messages, success: false }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end
end