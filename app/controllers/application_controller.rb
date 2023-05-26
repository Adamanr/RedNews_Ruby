class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:public]
  skip_before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  protect_from_forgery with: :null_session
  
  def not_found
    redirect_to root_path, alert: 'Страница не найдена'
  end
  private

  protected
  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :desc, :login, :role_id)}
     devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :email, :password, :current_password, :desc, :login, :city)}
  end
end
