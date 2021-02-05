class ApplicationController < ActionController::Base
  # if not(!) signed in, move to login
  before_action :authenticate_user!
  before_action :config_permitted_params, if: :devise_controller?
  def config_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end