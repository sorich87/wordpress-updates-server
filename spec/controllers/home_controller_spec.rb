require 'spec_helper'

describe HomeController do
  context 'user signed in' do
    sign_in_user

    describe "GET #index" do
      it "renders the :index view" do
        get :index
        response.should render_template "index"
        response.body.should eq ""
      end
    end

    describe 'POST #tour' do
      it 'ends the product tour' do
        post :tour, end: 'yes'
        @business.reload
        @business.tour.should == 'no'
      end
    end
  end

  describe "GET sorry" do
    it 'renders the sorry template' do
      get :sorry
      response.should render_template("sorry")
    end
  end

end
