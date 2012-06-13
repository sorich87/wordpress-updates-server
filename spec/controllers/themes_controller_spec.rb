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
    describe 'a theme with no previous versions' do
      before do
        theme
        get :show, id: theme.id
      end

      it { should assign_to(:theme).with(theme) }
      it { should assign_to(:older_versions).with(theme.versions) }
      it { should render_template(:show) }
    end

    describe 'a theme with previous versions' do
      before do
        theme.update_attributes(theme_version: '0.2.0')
        theme.reload
        @first_version = theme.versions[-1]
        get :show, id: theme.id
      end

      it { should assign_to(:theme).with(theme) }
      it { should assign_to(:older_versions).with([@first_version]) }
    end
  end
end