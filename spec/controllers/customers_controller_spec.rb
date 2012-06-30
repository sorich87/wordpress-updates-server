require 'spec_helper'

describe CustomersController do
  sign_in_user

  let(:customer) { Fabricate(:customer, businesses: [@business]) }

  describe "GET #index" do
    before do
      customer
      get :index
    end

    it { should assign_to(:customers).with([customer]) }
    it { should render_template(:index) }
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it { should assign_to(:customer).with_kind_of(Customer) }
    it { should render_template(:new) }
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new customer" do
        expect{
          post :create, customer: Fabricate.attributes_for(:customer)
        }.to change(Customer,:count).by(1)
      end

      it "adds a customer to the business" do
        customer = Fabricate(:customer, businesses: [])
        expect{
          post :create, customer: { email: customer.email }
          @business.reload
        }.to change(@business.customers,:count).by(1)
      end

      it "redirects to the customer purchases list" do
        customer = Fabricate(:customer, businesses: [])
        post :create, customer: { email: customer.email }
        response.should redirect_to customer_purchases_path(customer)
      end
    end

    context "with existing customer" do
      it "doesn't add the customer to the business" do
        customer
        expect{
          post :create, customer: { email: customer.email }
        }.to_not change(@business.customers,:count)
      end

      it "redirects to the customer purchases list" do
        post :create, customer: { email: customer.email }
        response.should redirect_to customer_purchases_path(customer)
      end
    end

    context "with invalid attributes" do
      it "does not save the new customer" do
        expect{
          post :create, customer: Fabricate.attributes_for(:customer, email: nil)
        }.to_not change(Customer,:count)
      end

      it "re-renders the new method" do
        post :create, customer: Fabricate.attributes_for(:customer, email: nil)
        response.should render_template :new
      end
    end
  end

  describe 'DELETE destroy' do
    it "removes the customer from the business" do
      delete :destroy, id: customer.id
      Business.find(@business.id).customer_ids.should_not include customer.id
    end

    it "redirects to customers#index" do
      delete :destroy, id: customer.id
      response.should redirect_to customers_path
    end
  end
end
