require 'spec_helper'

describe CustomersController do
  sign_in_user

  before :each do
    @customer = FactoryGirl.create(:customer, businesses: [@business])
  end

  describe "GET #index" do
    it "populates an array of customers" do
      get :index
      assigns(:customers).should == [@customer]
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new customer" do
        expect{
          post :create, customer: FactoryGirl.attributes_for(:customer)
        }.to change(Customer,:count).by(1)
      end

      it "adds an existing customer to the business" do
        customer_attributes = FactoryGirl.attributes_for(:customer)
        @customer = Customer.create(customer_attributes)
        post :create, customer: customer_attributes
        Business.find(@business.id).customer_ids.should include @customer.id
      end

      it "redirects to the customers list" do
        post :create, customer: FactoryGirl.attributes_for(:customer)
        response.should redirect_to customers_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new customer" do
        expect{
          post :create, customer: FactoryGirl.attributes_for(:customer, email: nil)
        }.to_not change(Customer,:count)
      end

      it "re-renders the new method" do
        post :create, customer: FactoryGirl.attributes_for(:customer, email: nil)
        response.should render_template :new
      end
    end
  end

  describe 'DELETE destroy' do
    it "removes the customer from the business" do
      delete :destroy, id: @customer.id
      Business.find(@business.id).customer_ids.should_not include @customer.id
    end

    it "redirects to customers#index" do
      delete :destroy, id: @customer.id
      response.should redirect_to customers_path
    end
  end
end
