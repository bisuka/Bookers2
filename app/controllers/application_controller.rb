class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

	#ログイン後のリダイレクト先
	def after_sign_in_path_for(resource)
	  user_path(resource.id)
	end

  protected

  # nameのデータ操作を許可するメソッド
  # ユーザ登録（sign_up）の際に、ユーザ名（name）のデータ操作が許可されます
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name,:email])
  end
end
