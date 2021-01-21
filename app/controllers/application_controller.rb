class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:home, :about, :contact]

  def home
    @user = current_user # this is a shortcut to access the logged in user. The @ symbol tells rails that this value should be accessible by the view
    @feature_flag = FeatureFlag.first # this is grabbing the first feature flag instance from the database (id: 1). You can access attributes like so: @feature_flag.value => true
  end

  def about
  end

  def contact
  end

  def secret
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
end
