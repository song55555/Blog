class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    if resource.save
      token = JWT.encode({ user_id: resource.id }, Rails.application.credentials.secret_key_base)
      render json: { user: resource, token: token, success: true }, status: :created
    else
      render json: { errors: resource.errors.full_messages, success: false }, status: :unprocessable_entity
    end
  end

  def update
      resource = current_user
    if resource.update(account_update_params)
      render json: resource
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

   def destroy
    resource = current_user
      if resource.destroy
        head :no_content
      else
        render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def sign_up_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end
end