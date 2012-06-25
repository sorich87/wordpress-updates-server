class CustomersController < ApplicationController

  def index
    @customers = @business.customers.asc(:email).page(params[:page]).per(20)
  end

  def new
    @customer = @business.customers.new(email: params[:email])
    @packages = @business.packages
  end

  def create
    @customer = @business.customers.build(customer_params)

    if @customer.save
      redirect_to customer_purchases_path(@customer), notice: 'Customer saved.'
    else
      render :new
    end
  end

  def destroy
    @business.customers.find(params[:id]).delete
    redirect_to customers_path, notice: 'Customer deleted.'
  end

  private

  def customer_params
    params[:customer].slice(:email)
  end
end
