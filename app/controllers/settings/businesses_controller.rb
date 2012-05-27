class Settings::BusinessesController < ApplicationController

  def edit
  end

  def update
    if @business.update_attributes(business_params)
      flash.now[:notice] = "Changes saved."
    else
      flash.now[:error] = "There were errors when updating your business settings."
    end
    render :edit
  end

  private
  def business_params
    params[:business].slice(:business_name, :email)
  end
end
