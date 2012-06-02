require "spec_helper"

describe SiteMailer do
  describe ".confirmation_instructions" do
    subject { SiteMailer.confirmation_instructions(site) }
    let(:site) { FactoryGirl.create(:unconfirmed_site) }
    it { should have_sent_email.with_subject(/Please Confirm Your Website$/) }
    it { should have_sent_email.to(site.customer.email) }
    #it { should have_sent_email.with_body(/#{site_confirmation_url}/) }
  end
end
