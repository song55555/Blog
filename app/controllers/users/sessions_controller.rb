# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /users/sign_in
  def new
    super

    puts '========================='
    puts 'GET /resource/sign_in'
    puts '========================='
  end

  # POST /users/sign_in
  def create
    super
  end

  # GET /users/sign_out
  # ここは config/initializers/devise.rb で config.sign_out_via = :get としているので DELETE ではなく GET
  def destroy
    super
  end

  protected

  # 許可するための追加のパラメータがある場合は、sanitizer に追加してください
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end