require 'spec_helper'

describe HomeController do
  describe "GET #index" do
    sign_in_user

    it "renders the :index view" do
      get :index
      response.should render_template "index"
      response.body.should eq ""
    end
  end

  describe "GET sorry" do
    it 'renders the sorry template' do
      get :sorry
      response.should render_template("sorry")
    end
  end

end
