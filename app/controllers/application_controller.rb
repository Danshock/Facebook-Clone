class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?
 

 protected

 def after_sign_in_path_for(resource_or_scope)
  home_path
 end

# Add these keys to the permited parameters (gem devise)
 def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
 end
end