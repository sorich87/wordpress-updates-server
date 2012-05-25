class CustomersController < ApplicationController
  def index
    @business = Business.first
    @customers = @business.customers
  end

  def new
    @business = Business.first
    @customer = @business.customers.new
    @packages = @business.packages
  end

  def create
    @business = Business.first
    @customer = Customer.new( customer_params.merge(business: @business) )
    if @customer.valid?
      @customer.save
      redirect_to customers_path, notice: "Customer saved."
    else
      render :new
    end
  end

  private

  def customer_params
    params[:customer].slice(:first_name, :last_name, :email)
  end
end