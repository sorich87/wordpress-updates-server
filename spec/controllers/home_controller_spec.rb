require 'spec_helper'

describe HomeController do
  sign_in_user

  describe "GET #index" do
    it "renders the :index view" do
      get :index
      response.should render_template "index"
      response.body.should eq ""
    end
  end

end
