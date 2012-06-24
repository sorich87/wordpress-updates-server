require 'spec_helper'

describe Extension do
  describe 'validations' do
    let(:extension) { Fabricate.build(:extension) }

    it 'is valid given valid attributes' do
      extension.should be_valid
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:current_version) }
    it { should validate_presence_of(:business) }
    it { should validate_presence_of(:versions) }

    it { should validate_uniqueness_of(:name).scoped_to(:business_id) }

    it { should belong_to(:business) }
    it { should embed_many(:versions) }

    it { should validate_attachment_presence(:screenshot) }
    it { should validate_attachment_content_type(:screenshot).allowing('image/gif', 'image/jpeg', 'image/png') }
  end

  describe 'versions' do
    let(:extension) { Fabricate(:extension) }

    describe 'changing the extension name' do
      it 'should not be allowed' do
        extension.update_attributes(name: 'Some other name').should be_false
      end

      it  'should generate an error message' do
        extension.name = "Some other extension name"
        extension.should_not be_valid
        extension.should have(1).error_on(:name)
      end
    end

    describe 'adding new versions' do
      before do
        extension.update_attributes(current_version: '2.0')
        extension.reload
      end

      it 'should reject older versions' do
        ['0.1', '0.9.1', '1.8', '1.9'].each do |version|
          extension.current_version = version
          extension.should have(1).error_on(:current_version)
        end
      end

      it 'should accept newer versions' do
        ['2.0.1', '2.5', '10.3', '13.37'].each do |version|
          extension.current_version = version
          extension.should be_valid
        end
      end
    end
  end
end
