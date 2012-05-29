class Settings::BusinessesController < ApplicationController

  def edit
  end

  def update
    if @business.update_attributes(business_params)
      flash[:notice] = "Changes saved."
      redirect_to settings_business_path
    else
      render :edit
    end
  end

  private
  def business_params
    params[:business].slice(:name, :email, :country, :time_zone, :street1, :street2, :city, :state, :zip, :phone)
  end
end
