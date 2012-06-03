class SitesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:confirm]

  def confirm
    unless params[:confirm_id].nil?
      @site = Site.where(confirmation_token: params[:confirm_id]).first
      unless @site.nil?
        @site.confirm!
      end
    end

    if @site.nil?
      @site = Site.new
    end
  end
end
