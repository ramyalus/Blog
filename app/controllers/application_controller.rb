class ApplicationController < ActionController::Base
	# rescue_from ActiveRecord::RecordNotFound do 
	# 	redirect_to root_path, alert: "Record not found for given id"
	# end 

	before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :gender, :mobile])
  end
end
