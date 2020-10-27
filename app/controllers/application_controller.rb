class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
  end

  def after_sign_in_path_for(resource)
    case resource
      when Admin
        admins_admins_top_path
      when User
        reviews_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      admins_sign_in_path
    else
      root_path
    end
  end

end

