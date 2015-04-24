class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  # There are just three actions in Devise that allows any set of parameters to be passed down to the model,
  # therefore requiring sanitization. Their names and the permited parameters by default are:

  # sign_in (Devise::SessionsController#new) - Permits only the authentication keys (like email)
  # sign_up (Devise::RegistrationsController#create) - Permits authentication keys plus password and password_confirmation
  # account_update (Devise::RegistrationsController#update) - Permits authentication keys plus password, password_confirmation
  # and current_password. More at https://github.com/plataformatec/devise#strong-parameters

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:username, :validate_username, :password, :password_confirmation, :invitation_token)
    end
    devise_parameter_sanitizer.for(:invite) do |u|
      u.permit(:name, :comments)
    end

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:username, :email, :password, :password_confirmation, :phone, :validate_username, :avatar_cache, :remove_avatar, :current_password, :remember_me)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :email, :password, :password_confirmation, :phone, :validate_username, :avatar, :avatar_cache, :remove_avatar, :current_password)
    end
  end
end
