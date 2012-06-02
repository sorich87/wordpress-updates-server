require "spec_helper"

describe SitesController do
  let!(:site) { FactoryGirl.create(:unconfirmed_site) }

  describe "GET confirm" do
    context "with valid attributes" do
      before do
        get :confirm, confirm_id: site.confirmation_token
      end

      it { should assign_to(:site).with(site) }
      it { should respond_with(:success)  }
      it { should render_template(:confirm)  }

      it "confirms the site" do
        Site.find(site.id).confirmed?.should be_true
      end
    end

    context "with invalid attributes" do
      it "redirects to the root path" do
        get :confirm, confirm_id: nil
        should redirect_to(root_path)
      end
    end
  end
end
