class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActionController::RoutingError, :with => :render_404

  def error_page
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  protected

  def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:full_name, :username, :email, :password, :password_confirmation)}

       devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:full_name, :username, :email, :password, :current_password)}
  end
end
