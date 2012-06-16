require 'spec_helper'

describe ThemesController do
  sign_in_user

  let!(:extension) { create(:theme, business: @business) }

  describe 'GET #index' do
    before do
      get :index
    end

    it { should assign_to(:extensions).with([extension]) }
    it { should render_template(:index) }
  end

  describe 'GET #show' do
    before do
      get :show, id: extension.id
    end

    it { should assign_to(:extension).with(extension) }
    it { should assign_to(:versions).with(extension.versions) }
    it { should render_template(:show) }
  end
end
