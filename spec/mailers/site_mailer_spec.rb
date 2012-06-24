require "spec_helper"

describe SiteMailer do
  describe ".confirmation_instructions" do
    let(:site) { Fabricate(:unconfirmed_site) }
    subject { SiteMailer.confirmation_instructions(site) }
    it { should have_subject(/Confirm Your Website for Automatic Updates$/) }
    it { should deliver_to(site.customer.email) }
    it { should have_body_text(/Click this link to confirm your website/) }
  end
end
