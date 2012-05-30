require 'spec_helper'

describe Settings::BusinessesController do
  sign_in_user

  describe 'GET edit' do
    it 'renders the edit template' do
      get :edit
      response.should render_template("edit")
    end
  end

  describe 'GET admin' do
    it 'renders the admin template' do
      get :admin
      response.should render_template("admin")
    end
  end

  describe 'PUT update' do
    before :each do
      @business.update_attributes(name: "Super Themes", email: "contact@super.thm")
    end

    context "valid attributes" do
      it "located the requested business" do
        put :update, id: @business, business: FactoryGirl.attributes_for(:business)
        assigns(:business).should == @business
      end

      it "changes the attributes of business" do
        put :update, id: @business,
          business: FactoryGirl.attributes_for(:business, name: "Awesome Themes", email: "contact@awesome.thm")
        @business.reload
        @business.name.should == "Awesome Themes"
        @business.email.should == "contact@awesome.thm"
      end

      it "redirects to the business settings page" do
        put :update, id: @business, business: FactoryGirl.attributes_for(:business)
        response.should redirect_to settings_business_path
      end
    end

    context "invalid attributes" do
      it "locates the requested business" do
        put :update, id: @business, business: FactoryGirl.attributes_for(:business, name: nil)
        assigns(:business).should == @business
      end

      it "does not change attributes of business" do
        put :update, id: @business,
          business: FactoryGirl.attributes_for(:business, email: nil)
        @business.reload
        @business.name.should == "Super Themes"
        @business.email.should == "contact@super.thm"
      end

      it "renders the edit method" do
        put :update, id: @business, business: FactoryGirl.attributes_for(:business, name: nil)
        response.should render_template :edit
      end
    end

  end

  describe "DELETE destroy" do
    context "valid password" do
      before :each do
        user_attributes = FactoryGirl.attributes_for(:user)
        @password = user_attributes[:password]
      end

      it "deletes the business" do
        expect{
          delete :destroy, password: @password
        }.to change(Business,:count).by(-1)
      end

      it "redirects to home#sorry" do
        delete :destroy, password: @password
        response.should redirect_to sorry_home_path
      end
    end

    context "invalid password" do
      it "does not delete the business" do
        expect{
          delete :destroy, password: "123456"
        }.to change(Business,:count).by(0)
      end

      it "redirect to business#admin" do
        delete :destroy, password: "123456"
        response.should redirect_to admin_settings_business_path
      end
    end
  end

end
