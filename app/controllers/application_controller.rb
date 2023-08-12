class ApplicationController < ActionController::Base

    include Pagy::Backend
    require 'pagy/extras/bootstrap'
    Pagy::DEFAULT[:items] = 5        # items per page

    before_action :configure_permitted_parameters, if: :devise_controller?
    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

end
