class SitesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:confirm]

  def confirm
    unless params[:confirm_id].nil?
      @site = Site.where(confirmation_token: params[:confirm_id]).first
      @site.confirm! unless @site.nil?
    end

    @site = Site.new if @site.nil?
  end
end
