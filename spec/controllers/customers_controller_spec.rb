require 'spec_helper'

describe CustomersController do
  sign_in_user

  let(:customer) { create(:customer, businesses: [@business]) }

  describe "GET #index" do
    before do
      customer
      get :index
    end

    it { should assign_to(:customers).with([customer]) }
    it { should render_template(:index) }
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new customer" do
        expect{
          post :create, customer: attributes_for(:customer)
        }.to change(Customer,:count).by(1)
      end

      it "adds an existing customer to the business" do
        @customer = create(:customer)
        post :create, customer: { email: @customer.email }
        Business.find(@business.id).customer_ids.should include @customer.id
      end

      it "redirects to the customer purchases list" do
        @customer = create(:customer)
        post :create, customer: { email: @customer.email }
        response.should redirect_to customer_purchases_path(@customer)
      end
    end

    context "with invalid attributes" do
      it "does not save the new customer" do
        expect{
          post :create, customer: attributes_for(:customer, email: nil)
        }.to_not change(Customer,:count)
      end

      it "re-renders the new method" do
        post :create, customer: attributes_for(:customer, email: nil)
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
