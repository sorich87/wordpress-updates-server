class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :load_business
  before_filter :set_time_zone

  protected

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def load_business
    @business = current_user.business if user_signed_in?
  end

  private

  def set_time_zone
    if user_signed_in?
      unless @business.time_zone.nil?
        timezone = ActiveSupport::TimeZone.new(@business.time_zone)
        Time.zone = @business.time_zone unless timezone.nil?
      end
    end
  end
end
