require 'spec_helper'

describe Extension do
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

  it 'responds to version attributes' do
    %w(uri author author_uri description license license_uri tags status template domain_path network text_domain).each do |m|
      extension.should respond_to(m)
    end
  end

  it 'returns the current version attributes' do
    extension = Fabricate(:extension)
    %w(uri author author_uri description license license_uri tags status template domain_path network text_domain).each do |m|
      extension.send(m).should == extension.versions.current.send(m)
    end
  end

  describe '.send_permission_notification' do
    it 'sends the permission notification email' do
      customer = Fabricate(:customer)
      extension.business.users << Fabricate(:user)
      expect {
        extension.send_permission_notification(customer)
      }.to change(ActionMailer::Base.deliveries, :length).by(1)
    end
  end

  describe 'changing the extension name' do
    let(:extension) { Fabricate(:extension) }

    it 'is not allowed' do
      extension.update_attributes(name: 'Some other name').should be_false
    end

    it  'generates an error message' do
      extension.name = "Some other extension name"
      extension.should have(1).error_on(:name)
    end
  end

  describe 'adding new versions' do
    before { extension.update_attributes(current_version: '2.0') }

    it 'rejects older versions' do
      ['0.1', '0.9.1', '1.8', '1.9'].each do |version|
        extension.current_version = version
        extension.should have(1).error_on(:current_version)
      end
    end

    it 'accepts newer versions' do
      ['2.0.1', '2.5', '10.3', '13.37'].each do |version|
        extension.current_version = version
        extension.should be_valid
      end
    end
  end
end
