require "spec_helper"

describe SitesController do
  let(:site) { Fabricate(:unconfirmed_site) }

  describe "GET confirm" do
    context "with valid attributes" do
      before do
        get :confirm, customer_id: site.customer.id, confirm_id: site.confirmation_token
      end

      it { should assign_to(:customer).with(site.customer) }
      it { should assign_to(:site).with(site) }
      it { should respond_with(:success)  }
      it { should render_template(:confirm)  }

      it "confirms the site" do
        site.reload
        site.confirmed?.should be_true
      end
    end

    context "with invalid attributes" do
      before do
        get :confirm, customer_id: site.customer.id, confirm_id: "1234"
      end

      it { should assign_to(:customer).with(site.customer) }
      it { should assign_to(:site).with(nil) }
      it { should respond_with(:success)  }
      it { should render_template(:confirm)  }
    end
  end
end
