class PurchasesController < ApplicationController
  before_filter :load_customer

  def index
    @purchases = @customer.purchases.find_by_business(@business)
    @purchase = Purchase.new
  end

  def create
    @purchases = @customer.purchases.find_by_business(@business)

    build_params = purchase_params
    build_params[:package] = @business.packages.find(purchase_params[:package_id]) unless purchase_params[:package_id].nil?
    build_params[:business_id] = @business._id
    @purchase = Purchase.new(build_params)
    @purchase.customer = @customer

    if @purchase.save
      redirect_to customer_purchases_path(@customer), notice: 'Purchase saved.'
    else
      flash[:error] = 'Error saving purchase.'
      render :index
    end
  end

  def renew
    @purchase = @customer.purchases.find_by_business(@business).find(params[:id]).renew_suscription!
    redirect_to customer_purchases_path(@customer), notice: 'Subscription renewed.'
  end

  def destroy
    @customer.purchases.find_by_business(@business).find(params[:id]).delete
    redirect_to customer_purchases_path(@customer), notice: 'Purchase deleted.'
  end

  private

  def load_customer
    @customer = @business.customers.find(params[:customer_id])
  end

  def purchase_params
    params[:purchase].slice(:package_id, :"purchase_date(1i)", :"purchase_date(2i)", :"purchase_date(3i)", :extension_ids,
                           :package_name, :price, :is_subscription, :validity, :number_of_domains)
  end
end
