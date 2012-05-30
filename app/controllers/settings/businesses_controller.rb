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

  def destroy
    if current_user.valid_password?(params[:password])
      sign_out current_user
      @business.destroy
      redirect_to sorry_home_path
    else
      flash[:error] = "Password invalid."
      redirect_to admin_settings_business_path
    end
  end

  def admin
  end

  private
  def business_params
    params[:business].slice(:name, :email, :country, :time_zone, :street1, :street2, :city, :state, :zip, :phone)
  end
end
