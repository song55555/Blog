class Users::PasswordsController < Devise::PasswordsController

  def create
      user = User.find_by(email: params[:user][:email])
          if user
               user.send_reset_password_instructions
                 head :no_content
            else
                render json: {error: 'User not found'}, status: :not_found
            end
  end

  def update
        resource = User.reset_password_by_token(params[:user])
      if resource.errors.empty?
           render json: resource, status: :ok
      else
          render json: resource.errors, status: :unprocessable_entity
        end
  end
end