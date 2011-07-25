class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "Access denied."
  end  
    
  private

  def after_update_path_for(resource)
    resource # You can put whatever path you want here
  end  
  
end
