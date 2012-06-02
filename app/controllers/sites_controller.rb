class SitesController < ApplicationController
  skip_before_filter :authenticate_user!

  def confirm
    if params[:confirm_id].nil?
      redirect_to root_path
      return
    end

    @site = Site.where(confirmation_token: params[:confirm_id]).first
    if @site.nil?
      redirect_to root_path
      return
    end

    @site.confirm!
  end
end
