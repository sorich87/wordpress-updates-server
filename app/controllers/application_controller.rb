class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :load_business

  protected

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def load_business
    @business = current_user.business if user_signed_in?
  end
end
