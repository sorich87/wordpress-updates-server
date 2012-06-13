require 'spec_helper'

describe PackagesController do
  sign_in_user
  let(:theme) { create(:theme, business: @user.business) }

  describe 'GET #edit' do
    let(:package) { create(:package, business: @user.business, theme_ids: [theme.id]) }

    before do
      get :edit, :id => package.id
    end

    it { should assign_to(:package).with(package) }
    it { should render_template(:edit) }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new package in the database' do
        expect{
          post :create, package: attributes_for(:package, theme_ids: [theme.id])
        }.to change(Package,:count).by(1)
      end

      it 'redirects to the packages page' do
        post :create, package: attributes_for(:package, theme_ids: [theme.id])
        response.should redirect_to packages_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new package in the database' do
        expect{
          post :create, package: attributes_for(:invalid_package)
        }.to change(Package,:count).by(0)
      end

      it 're-render the :edit template' do
        post :create, package: attributes_for(:invalid_package)
        response.should render_template :edit
      end
    end
  end

  describe 'GET #index' do
    before do
      get :index
    end

    it { should assign_to(:packages) }
    it { should assign_to(:new_package) }
    it { should render_template(:index)  }
  end

  describe 'PUT #update' do
    let(:package) do
      create(:package, business: @user.business, name: 'Some Package', 
              description: 'A great description', theme_ids: [theme.id])
    end

    it "locates the requested package" do
      put :update, id: package.id, package: attributes_for(:package)
      assigns(:package).should == package
    end

    context 'with valid attributes' do
      it "change package's attributes" do
        put :update, id: package.id, 
                     package: attributes_for(:package, name: 'A Package', theme_ids: [theme.id])
        package.reload
        package.name.should == 'A Package'
      end

      it 'redirects to the packages page' do
        put :update, id: package.id, package: attributes_for(:package, theme_ids: [theme.id])
        response.should redirect_to packages_path
      end
    end

    context 'with invalid attributes' do
      it "does not change package's attributes" do
        put :update, id: package.id, 
                     package: attributes_for(:package, name: 'A Broken Package', description: nil)
        package.reload
        package.name.should_not == 'A Broken Package'
        package.description.should == 'A great description'
      end

      it 're-renders the :edit template' do
        put :update, id: package.id, package: attributes_for(:invalid_package)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:package) { create(:package, business: @user.business, theme_ids: [theme.id]) }

    it 'deletes the package from the database' do
      expect{
        delete :destroy, id: package.id
      }.to change(Package,:count).by(-1)
    end

    it 'redirects to the packages page' do
      delete :destroy, id: package.id
      response.should redirect_to packages_path
    end
  end
end
