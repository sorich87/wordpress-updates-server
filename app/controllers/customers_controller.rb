class CustomersController < ApplicationController

  def index
    @customers = @business.customers.asc(:email).page(params[:page]).per(20)
  end

  def new
    @customer = @business.customers.new(email: params[:email])
    @packages = @business.packages
  end

  def create
    @customer = Customer.find_or_initialize_by(email: customer_params[:email])

    if @customer.business_ids.include?(@business.id)
      redirect_to customer_purchases_path(@customer), notice: 'Customer already exists.'
    else
      @customer.businesses << @business

      if @customer.save
        redirect_to customer_purchases_path(@customer), notice: 'Customer saved.'
      else
        render :new
      end
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @business.customers -= [@customer]
    redirect_to customers_path, notice: 'Customer deleted.'
  end

  private

  def customer_params
    params[:customer].slice(:email)
  end
end
