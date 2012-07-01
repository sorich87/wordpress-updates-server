require 'spec_helper'

describe VersionsController do
  sign_in_user

  let(:version) { Fabricate.build(:version) }
  let(:extension) { Fabricate(:theme, business: @business, versions: [version]) }

  describe 'DELETE #destroy' do
    it 'deletes the version' do
      version2 = Fabricate(:version, extension: extension)
      extension.reload
      delete :destroy, extension_id: extension.id, id: version.id
      extension.reload
      extension.versions.should_not include version
    end

    it 'does not delete the only one version' do
      delete :destroy, extension_id: extension.id, id: version.id
      extension.reload
      extension.versions.should include version
    end
  end
end
