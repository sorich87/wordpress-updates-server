require 'spec_helper'

describe Api::V1::TokensController do
  before :each do
    @site = FactoryGirl.create(:confirmed_site)
  end

  describe "POST create" do
    context "with valid attributes" do
      it "locates the requested customer" do
        post :create, email: @site.customer.email, domain_name: @site.domain_name, secret_key: @site.secret_key
        assigns(:customer).should == @site.customer
      end

      it "locates the requested site" do
        post :create, email: @site.customer.email, domain_name: @site.domain_name, secret_key: @site.secret_key
        assigns(:site).should == @site
      end

      it "renders the authentication token" do
        @site.customer.ensure_authentication_token!
        post :create, email: @site.customer.email, domain_name: @site.domain_name, secret_key: @site.secret_key
        response.body.should == { token: @site.customer.authentication_token }.to_json
      end
    end

    context "with invalid attributes" do
      it "returns error code 1 when an attribute is missing" do
        post :create, email: nil
        body = JSON.parse(response.body)
        body["code"].should == 1
      end

      it "returns error code 10 when the customer doesn't exist" do
        post :create, email: "test@test.com", domain_name: @site.domain_name, secret_key: @site.secret_key
        body = JSON.parse(response.body)
        body["code"].should == 10
      end

      it "returns error code 20 when the site doesn't exist" do
        post :create, email: @site.customer.email, domain_name: "test.com", secret_key: "1234"
        body = JSON.parse(response.body)
        body["code"].should == 20
      end

      it "returns error code 20 when the site has not been confirmed" do
        post :create, email: @site.customer.email, domain_name: "test.com", secret_key: "1234"
        body = JSON.parse(response.body)
        body["code"].should == 20
      end

      it "returns error code 21 when the secret key is invalid" do
        @site.confirm!
        post :create, email: @site.customer.email, domain_name: @site.domain_name, secret_key: "1234"
        body = JSON.parse(response.body)
        body["code"].should == 21
      end
    end
  end

  describe "DELETE destroy" do
    context "with valid attributes" do
      it "resets the authentication token" do
        @site.customer.ensure_authentication_token!
        delete :destroy, id: @site.customer.authentication_token
        Customer.where(authentication_token: @site.customer.authentication_token).first.should == nil
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
