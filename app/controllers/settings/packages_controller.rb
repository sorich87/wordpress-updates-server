class Settings::PackagesController < ApplicationController
  before_filter :get_business

  def edit
    @package = @business.packages.find(params[:id])
  end

  def create
    @package = @business.packages.build(package_params)
    if @package.save
      flash[:notice] = "Package has been saved."
      redirect_to settings_packages_path
    else
      flash[:error] = "Error saving your package."
      render :edit
    end
  end

  def index
    @packages = @business.packages
    @new_package = Package.new
  end

  def update
    @package = @business.packages.find(params[:id])
    if @package.update_attributes(package_params)
      redirect_to settings_packages_path, notice: "Package saved."
    else
      render :edit
    end
  end

  def destroy
    @package = @business.packages.find(params[:id])
    @package.destroy
    redirect_to settings_packages_path, notice: "Package removed."
  end


  private

  def package_params
    params[:package].slice(:name, :description, :price, :validity, :billing, :themes, :domains)
  end

  def get_business
    # TODO: Needs to be re-implemented
    @business = Business.first
  end
end