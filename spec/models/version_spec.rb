require 'spec_helper'

describe Version do
  let(:version) { Fabricate.build(:version) }

  it 'is valid given valid attributes' do
    version.should be_valid
  end

  it { should validate_presence_of(:version) }

  it { should validate_attachment_presence(:archive) }
  it { should validate_attachment_content_type(:archive).allowing('application/zip') }

  it { should be_embedded_in(:extension) }
end
