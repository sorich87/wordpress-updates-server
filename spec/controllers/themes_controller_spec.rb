require 'spec_helper'

describe ThemesController do
  sign_in_user

  let(:theme) { create(:theme, business: @business) }

  describe 'GET #index' do
    before do
      theme
      get :index
    end

    it { should assign_to(:themes).with([theme]) }
    it { should render_template(:index) }
  end

  describe 'GET #show' do
    before do
      theme
      get :show, id: theme.id
    end

    it { should assign_to(:theme).with(theme) }
    it { should assign_to(:versions).with(theme.versions) }
    it { should render_template(:show) }
  end
end
