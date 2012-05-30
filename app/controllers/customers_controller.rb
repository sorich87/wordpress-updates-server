class CustomersController < ApplicationController

  def index
    @customers = @business.customers
  end

  def new
    @customer = @business.customers.new
    @packages = @business.packages
  end

  def create
    @customer = Customer.new( customer_params.merge(business: @business) )
    if @customer.save
      redirect_to customers_path, notice: "Customer saved."
    else
      render :new
    end
  end

  def destroy
    @customer = @business.customers.find(params[:id])
    @customer.destroy
    redirect_to customers_path
  end

  private

  def customer_params
    params[:customer].slice(:email)
  end
end
