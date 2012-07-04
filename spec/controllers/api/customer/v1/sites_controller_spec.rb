require 'spec_helper'

describe Api::Customer::V1::SitesController do
  let(:site) { Fabricate(:unconfirmed_site) }

  describe "POST create" do
    context "with valid attributes" do
      it "locates the requested customer" do
        post :create, email: site.customer.email, domain_name: site.domain_name, secret_key: site.unconfirmed_secret_key
        assigns(:customer).should == site.customer
      end

      it "locates the requested site" do
        post :create, email: site.customer.email, domain_name: site.domain_name, secret_key: site.unconfirmed_secret_key
        assigns(:site).should == site
      end

      it "creates a new site" do
        count = Customer.find(site.customer.id).sites.count
        post :create, email: site.customer.email, domain_name: "test.com", secret_key: "12345"
        Customer.find(site.customer.id).sites.count.should == count + 1
      end

      it "sends confirmation instructions" do
        expect {
          post :create, email: site.customer.email, domain_name: site.domain_name, secret_key: site.unconfirmed_secret_key
        }.to change(ActionMailer::Base.deliveries, :length).by(1)
      end
    end

    context "with invalid attributes" do
      it "returns error code 1 when an attribute is missing" do
        post :create, email: nil
        body = JSON.parse(response.body)
        body["code"].should == 1
      end

      it "returns error code 2 when the email is not valid" do
        post :create, email: "test@test;com", domain_name: site.domain_name, secret_key: "12345"
        body = JSON.parse(response.body)
        body["code"].should == 2
      end

      it "returns error code 2 when the domain name is not valid" do
        post :create, email: site.customer.email, domain_name: "test;com", secret_key: "12345"
        body = JSON.parse(response.body)
        body["code"].should == 2
      end

      it "returns error code 22 when the site has already been confirmed" do
        site.confirm!
        post :create, email: site.customer.email, domain_name: site.domain_name, secret_key: site.secret_key
        body = JSON.parse(response.body)
        body["code"].should == 22
      end

    end
  end

end
