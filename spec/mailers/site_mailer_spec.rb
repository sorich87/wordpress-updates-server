require "spec_helper"

describe SiteMailer do
  describe ".confirmation_instructions" do
    let(:site) { FactoryGirl.create(:unconfirmed_site) }
    subject { SiteMailer.confirmation_instructions(site) }
    it { should have_subject(/Please Confirm Your Website$/) }
    it { should deliver_to(site.customer.email) }
    it { should have_body_text(/Confirm my website/) }
  end
end
