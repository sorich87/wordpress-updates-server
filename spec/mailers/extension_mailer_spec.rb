require "spec_helper"

describe ExtensionMailer do
  describe ".permission_notification" do
    before do
      @business = Fabricate(:business)
      @user = Fabricate(:user, business: @business)
      @extension = Fabricate(:extension, business: @business)
      @customer = Fabricate(:customer)
    end
    subject { ExtensionMailer.permission_notification(@extension, @customer) }
    it { should have_subject(/Push.ly Customer Authorization$/) }
    it { should deliver_to(@user.email) }
    it { should have_body_text(/Approve #{@customer.email}/) }
  end
end
