require 'spec_helper'

describe PurchasesController do
  sign_in_user

  let(:business2) { Fabricate(:business) }
  let(:package) { Fabricate(:package, business: @business) }
  let(:extension) { Fabricate(:extension, business: @business) }
  let!(:customer) { Fabricate(:customer, businesses: [@business, business2]) }
  let(:purchase) { Fabricate(:purchase, customer: customer, business_id: @business.id, is_subscription: true, validity: 3) }
  let(:purchase2) { Fabricate(:purchase, customer: customer, business_id: business2.id) }
  let(:attributes) { Fabricate.attributes_for(:purchase, :package_id => package.id, :extension_ids => [extension.id],
                                              :"purchase_date(1i)" => 2012, :"purchase_date(2i)" => 1, :"purchase_date(3i)" => 12) }

  describe 'GET #index' do
    before do
      purchase
      get :index, customer_id: customer.id
    end

    it { should assign_to(:purchases).with([purchase]) }
    it { should assign_to(:purchase).with_kind_of(Purchase) }
    it { should render_template(:index) }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the purchase in the database' do
        count = customer.purchases.count
        post :create, customer_id: customer.id, purchase: attributes
        customer.reload
        customer.purchases.count == count + 1
      end

      it "redirects to the customer's purchases index" do
        post :create, customer_id: customer.id, purchase: attributes
        response.should redirect_to customer_purchases_url(customer)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the purchase in the database' do
        count = customer.purchases.count
        post :create, customer_id: customer.id, purchase: Fabricate.attributes_for(:purchase, package_id: nil)
        customer.reload
        customer.purchases.count == count
      end

      it 're-renders the :index template' do
        post :create, customer_id: customer.id, purchase: Fabricate.attributes_for(:purchase, package_id: nil)
        response.should render_template :index
      end
    end
  end

  describe 'GET #renew' do
    it 'renew the subscription' do
      expiration_date = purchase.expiration_date
      get :renew, customer_id: customer.id, id: purchase.id
      purchase.reload
      purchase.expiration_date.should == expiration_date >> purchase.validity
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the purchase' do
      count = customer.purchases.count
      delete :destroy, customer_id: customer.id, id: purchase.id
      customer.reload
      customer.purchases.count == count - 1
    end

    it 'redirects to customer_purchases#index' do
      delete :destroy, customer_id: customer.id, id: purchase.id
      response.should redirect_to customer_purchases_url(customer)
    end
  end
end
