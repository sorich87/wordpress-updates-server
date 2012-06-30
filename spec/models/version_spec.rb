require 'spec_helper'

describe Version do
  let(:version) { Fabricate.build(:version) }

  it 'is valid given valid attributes' do
    version.should be_valid
  end

  it { should validate_presence_of(:version) }

  it { should validate_attachment_presence(:archive) }

  it { should be_embedded_in(:extension) }

  describe '.download_url' do
    it 'returns a valid Amazon URL' do
      version.download_url.should include "https://thememy-test.s3.amazonaws.com/extensions/archives/#{version.id}/#{version.archive_file_name}?AWSAccessKeyId="
    end
  end
end
