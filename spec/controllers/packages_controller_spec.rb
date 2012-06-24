require 'spec_helper'

describe PackagesController do
  sign_in_user
  let(:extension) { Fabricate(:extension, business: @business) }

  describe 'GET #edit' do
    let(:package) { Fabricate(:package, business: @business, extension_ids: [extension.id]) }

    before do
      get :edit, :id => package.id
    end

    it { should assign_to(:package).with(package) }
    it { should render_template(:edit) }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new package in the database' do
        count = @business.packages.count
        post :create, package: Fabricate.attributes_for(:package, extension_ids: [extension.id])
        @business.reload
        @business.packages.count == count + 1
      end

      it 'redirects to the packages page' do
        post :create, package: Fabricate.attributes_for(:package, extension_ids: [extension.id])
        response.should redirect_to packages_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new package in the database' do
        count = @business.packages.count
        post :create, package: Fabricate.attributes_for(:invalid_package)
        @business.reload
        @business.packages.count == count
      end

      it 're-render the :edit template' do
        post :create, package: Fabricate.attributes_for(:invalid_package)
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
      Fabricate(:package, business: @business, name: 'Some Package', 
              description: 'A great description', extension_ids: [extension.id])
    end

    it "locates the requested package" do
      put :update, id: package.id, package: Fabricate.attributes_for(:package)
      assigns(:package).should == package
    end

    context 'with valid attributes' do
      it "change package's attributes" do
        put :update, id: package.id, 
                     package: Fabricate.attributes_for(:package, name: 'A Package', extension_ids: [extension.id])
        package.reload
        package.name.should == 'A Package'
      end

      it 'redirects to the packages page' do
        put :update, id: package.id, package: Fabricate.attributes_for(:package, extension_ids: [extension.id])
        response.should redirect_to packages_path
      end
    end

    context 'with invalid attributes' do
      it "does not change package's attributes" do
        put :update, id: package.id,
                     package: Fabricate.attributes_for(:package, name: 'A Broken Package', description: nil)
        package.reload
        package.name.should_not == 'A Broken Package'
        package.description.should == 'A great description'
      end

      it 're-renders the :edit template' do
        put :update, id: package.id, package: Fabricate.attributes_for(:invalid_package)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:package) { Fabricate(:package, business: @business, extension_ids: [extension.id]) }

    it 'deletes the package from the database' do
      delete :destroy, id: package.id
      @business.reload
      @business.packages.should_not include package
    end

    it 'redirects to the packages page' do
      delete :destroy, id: package.id
      response.should redirect_to packages_path
    end
  end
end
