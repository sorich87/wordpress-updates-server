require 'spec_helper'

describe Api::V1::TokensController do
  before :each do
    @customer = FactoryGirl.create(:customer)
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new customer" do
        expect{
          post :create, email: "test@test.thm"
        }.to change(Customer,:count).by(1)
      end

      it "locates the requested customer" do
        post :create, email: @customer.email
        assigns(:customer).should == @customer
      end

      it "renders the authentication token" do
        post :create, email: @customer.email
        response.body.should_not == { token: nil }.to_json
      end
    end

    context "with invalid attributes" do
      it "has 400 status code" do
        post :create, email: nil
        response.code.should == "400"
      end
    end
  end

  describe "DELETE destroy" do
    context "with valid attributes" do
      it "resets the authentication token" do
        @customer.ensure_authentication_token!
        delete :destroy, id: @customer.authentication_token
        response.body.should == { token: @customer.authentication_token }.to_json
      end
    end

    context "with invalid attributes" do
      it "has 404 status code" do
        delete :destroy, id: "a"
        response.code.should == "404"
      end
    end
  end

end
