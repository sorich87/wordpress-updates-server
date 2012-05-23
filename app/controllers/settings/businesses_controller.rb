class Settings::BusinessesController < ApplicationController
  def show
    @business = Business.first || Business.new
    render :edit
  end

  def edit
    # Because we don't have users or anything like that yet.
    @business = Business.first || Business.new
  end

  def update
    @business = Business.first
    if @business.update_attributes(business_params)
      flash.now[:success] = "Business settings updated."
    else
      flash.now[:error] = "There were errors when updating your business settings."
    end
    render :edit
  end

  def create
    @business = Business.new(business_params)

    if @business.save
      flash[:success] = "Business settings updated."
    else
      flash[:error] = "There were errors when updating your business settings."
    end
    render :edit
  end


  private
  def business_params
    params[:business].slice(:name, :email)
  end
end