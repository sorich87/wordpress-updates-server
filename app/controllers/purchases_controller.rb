class PurchasesController < ApplicationController
  before_filter :load_customer

  def index
    @purchases = @customer.purchases.current
    new
  end

  def new
    @purchase = Purchase.new
  end

  def edit
    @purchase = @customer.purchases.find(params[:id])
  end

  def create
    @purchase = @customer.purchases.build(purchase_params)

    if @purchase.save
      flash[:notice] = "Purchase saved."
      redirect_to customer_purchases_path(@customer)
    else
      flash[:error] = "Error saving purchase."
      render :edit
    end
  end

  def update
    @purchase = @customer.purchases.find(params[:id])

    if @purchase.update_attributes(purchase_params)
      flash[:notice] = "Purchase saved."
      redirect_to customer_purchases_path(@customer)
    else
      flash[:error] = "Error saving purchase."
      render :edit
    end
  end

  def destroy
    @purchase = @customer.purchases.find(params[:id])
    @customer.purchases -= [@purchase]
    flash[:notice] = "Purchase deleted."
    redirect_to customer_purchases_path(@customer)
  end

  private

  def load_customer
    @customer = Customer.find(params[:customer_id])
  end

  def purchase_params
    params[:purchase].slice(:package_id, "purchase_date(1i)", "purchase_date(2i)", "purchase_date(3i)", :theme_ids)
  end
end
