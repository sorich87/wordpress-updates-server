require 'spec_helper'

describe ExtensionsController do
  sign_in_user

  let(:extension) { Fabricate(:theme, business: @business) }
  let(:valid) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/themes/zips/annotum-base.zip')) }
  let(:invalid) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/themes/zips/invalid/screenshot_missing.zip')) }

  describe 'GET #index' do
    before do
      extension
      get :index, model: "Theme"
    end

    it { should assign_to(:extensions).with(@business.extensions.where(_type: "Theme")) }
    it { should render_template(:index) }
  end

  describe 'GET #show' do
    before do
      get :show, model: "Theme", id: extension.id
    end

    it { should assign_to(:extension).with(extension) }
    it { should assign_to(:versions).with(extension.versions) }
    it { should render_template(:show) }
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new extension" do
        valid
        expect{
          post :create, model: 'Theme', file: valid, format: :js
        }.to change(Extension,:count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new extension" do
        invalid
        expect{
          post :create, model: 'Theme', file: invalid, format: :js
        }.to_not change(Extension,:count)
      end
    end
  end

  describe 'POST update' do
    let(:extension) { Fabricate(:theme, business: @business, current_version: '0.1') }

    context 'with valid attributes' do
      it 'locates the requested extension' do
        post :update, model: 'Theme', id: extension.id, file: valid, format: :js
        assigns(:extension).should == extension
      end

      it "changes extension's attributes" do
        post :update, model: 'Theme', id: extension.id, file: valid, format: :js
        extension.reload
        extension.current_version.should == '1.0'
      end
    end

    context 'invalid attributes' do
      it "does not change extension's attributes" do
        post :update, model: 'Theme', id: extension.id, file: invalid, format: :js
        extension.reload
        extension.current_version.should == '0.1'
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the extension' do
      extension
      expect{
        delete :destroy, model: 'Theme', id: extension.id
      }.to change(Extension,:count).by(-1)
    end

    it 'redirects to extensions#index' do
      delete :destroy, model: 'Theme', id: extension.id
      response.should redirect_to themes_url
    end
  end
end
