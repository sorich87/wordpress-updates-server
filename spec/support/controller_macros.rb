module ControllerMacros
  def sign_in_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:designer)
      @business = @user.business
      sign_in @user
    end
  end
end
