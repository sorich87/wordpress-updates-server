require 'spec_helper'

describe Theme do
  let(:business) { Fabricate.build(:business) }

  it 'is valid given a valid file' do
    filename = File.join(Rails.root, 'spec/fixtures/themes/zips/annotum-base.zip')
    file = File.new(filename)
    tempfile = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
    tp = ThemeParser.new(file)
    theme = business.extensions.new(name: tp.attributes[:name],
                                new_version: tp.attributes.merge(archive: tempfile),
                                _type: 'Theme')
    theme.should be_valid
  end
end
