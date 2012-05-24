class Settings::PackagesController < ApplicationController
  def edit
    @business = Business.first
    @package = @business.packages.find(params[:id])
  end

  def create
    @business = Business.first
    @package = @business.packages.build(package_params)
    if @package.save
      flash[:success] = "Package has been saved."
      @new_package = Package.new
    else
      @new_package = @package
      flash[:error] = "Error saving your package."
    end

    @packages = @business.packages
    render :edit
  end

  def index
    @business = Business.first
    @packages = @business.packages
    @new_package = Package.new
  end

  private

  def package_params
    params[:package].slice(:name, :description, :price, :validity, :billing, :themes, :domains)
  end

end