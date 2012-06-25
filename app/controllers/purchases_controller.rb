class PurchasesController < ApplicationController
  before_filter :load_customer

  def index
    @purchases = @customer.purchases
    new
  end

  def new
    @purchase = Purchase.new
  end

  def edit
    @purchase = @customer.purchases.find(params[:id])
  end

  def create
    build_params = purchase_params
    build_params[:package] = @business.packages.find(purchase_params[:package_id])
    build_params[:business_id] = @business._id
    @purchase = @customer.purchases.build(build_params)

    if @purchase.save
      redirect_to customer_purchases_path(@customer), notice: 'Purchase saved.'
    else
      render :edit, error: 'Error saving purchase.'
    end
  end

  def destroy
    @customer.purchases.find(params[:id]).delete
    redirect_to customer_purchases_path(@customer), notice: 'Purchase deleted.'
  end

  private

  def load_customer
    @customer = Customer.find(params[:customer_id])
  end

  def purchase_params
    params[:purchase].slice(:package_id, :"purchase_date(1i)", :"purchase_date(2i)", :"purchase_date(3i)", :extension_ids,
                           :package_name, :price, :billing, :validity, :number_of_domains)
  end
end
