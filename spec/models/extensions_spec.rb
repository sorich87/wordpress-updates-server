require 'spec_helper'

describe Extension do 
  before do
    @business = FactoryGirl.create(:business)
  end

  describe 'validations' do
    describe 'without attribute' do
      specify 'name' do
        FactoryGirl.build(:extension, business: @business, name: nil).should_not be_valid
      end

      specify 'version' do
        FactoryGirl.build(:extension, business: @business, extension_version: nil).should_not be_valid
      end

      specify 'business' do
        FactoryGirl.build(:extension, business: nil).should_not be_valid
      end
    end

    it 'should not let the designer upload a extension with the same name' do
      first_extension = FactoryGirl.create(:extension, business: @business, name: "Some extension")
      second_extension = FactoryGirl.build(:extension, business: @business, name: "Some extension")

      second_extension.should_not be_valid
    end

    it 'should accept duplicate names if the designers are different' do
      second = FactoryGirl.create(:business)
      first_extension = FactoryGirl.create(:extension, business: @business, name: "Some extension")
      second_extension = FactoryGirl.build(:extension, business: second, name: "Some extension")

      second_extension.should be_valid
    end

    it 'should reject invalid version numbers' do
      ['.0.1', '.1', '0.a.1', '10.*.1'].each do |version_number|
        Extension.new(extension_version: version_number).should have(1).error_on(:extension_version)
      end
    end
  end

  it { should belong_to(:business) }
  it { should have_and_belong_to_many(:purchases) }
  it { should have_and_belong_to_many(:packages) }

  describe 'VERSIONS' do
    before do
      @extension = FactoryGirl.create(:extension, business: @business)
    end

    it { should respond_to(:get_version) }
    it { should respond_to(:get_newer_versions_than) }
    it { should respond_to(:get_older_versions_than) }
    it { should respond_to(:deactivate_version!) }
    it { should respond_to(:active?) }
    specify { @extension.active?.should be_true }

    it 'should add another version when being updated' do
      lambda {
        @extension.update_attributes(extension_version: '2.0')
      }.should change(@extension, :version).by(1)
    end

    describe 'changing the extension name' do
      it 'should not be allowed' do
        @extension.update_attributes(name: 'Some other name').should be_false
      end

      it  'should generate an error message' do
        @extension.name = "Some other extension name"
        @extension.should_not be_valid
        @extension.should have(1).error_on(:name)
      end
    end

    describe 'getting versions' do
      before do
        @extension.update_attributes(extension_version: '2.0')
        @extension.reload
        @old_version = @extension.versions[-1]
      end

      # Getting specific versions
      specify { @extension.get_version(1).extension_version.should == '0.1.0' }
      specify { @extension.get_version(1).should == @old_version }
      specify { @extension.get_version(1).version.should == 1 }

      # Getting older versions
      specify { @extension.get_older_versions_than(@extension.version).should == [@old_version] }
      specify { @extension.get_older_versions_than(@extension).should == [@old_version] }

      # Getting newer versions
      specify { @extension.get_newer_versions_than(@old_version.version).should == [@extension] }
      specify { @extension.get_newer_versions_than(@old_version).should == [@extension] }
    end

    describe 'adding new versions' do
      before do
        @extension.update_attributes(extension_version: '2.0')
        @extension.reload
      end

      it 'should reject older versions' do
        ['0.1', '0.9.1', '1.8', '1.9'].each do |version|
          @extension.extension_version = version
          @extension.should have(1).error_on(:extension_version)
        end
      end

      it 'should accept newer versions' do
        ['2.0.1', '2.5', '10.3', '13.37'].each do |version|
          @extension.extension_version = version
          @extension.should be_valid
        end
      end
    end
  end
end
