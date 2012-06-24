module ControllerMacros
  def sign_in_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]

      @user_attributes = Fabricate.attributes_for(:user)
      @business_attributes = Fabricate.attributes_for(:business)

      @business = Business.create(@business_attributes)
      @user = User.create(@user_attributes.merge(business: @business))
      sign_in @user
    end
  end
end
