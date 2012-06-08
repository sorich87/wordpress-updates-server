class CustomersController < ApplicationController

  def index
    @customers = @business.customers.asc(:email).page(params[:page]).per(20)
  end

  def new
    @customer = @business.customers.new
    @packages = @business.packages
  end

  def create
    @customer = Customer.find_or_initialize_by(email: customer_params[:email])

    if @customer.business_ids.include?(@business.id)
      @customer.errors.add(:email, "is already taken")
      @customer._id = nil
      render :new
    else
      @customer.businesses << @business
      if @customer.save
        redirect_to customer_purchases_path(@customer), notice: "Customer saved."
      else
        render :new
      end
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @business.customers -= [@customer]
    flash[:notice] = "Customer deleted."
    redirect_to customers_path
  end

  private

  def customer_params
    params[:customer].slice(:email)
  end
end
