class SitesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:confirm]

  def confirm
    @customer = Customer.find(params[:customer_id])

    unless @customer.nil?
      @site = @customer.sites.where(confirmation_token: params[:confirm_id]).first

      @site.confirm! unless @site.nil?
    end
  end
end
