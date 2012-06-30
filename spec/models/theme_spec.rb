require 'spec_helper'

describe Theme do
  let(:business) { Fabricate.build(:business) }

  before(:all) do
    filename = File.join(Rails.root, 'spec/fixtures/themes/zips/annotum-base.zip')
    file = File.new(filename)
    tempfile = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
    @tp = ThemeParser.new(file)
    @theme = business.extensions.new(name: @tp.attributes[:name],
                                new_version: @tp.attributes.merge(archive: tempfile),
                                _type: 'Theme')
  end

  it 'is valid given a valid file' do
    @theme.should be_valid
  end

  it 'adds the screenshot' do
    @theme.screenshot.should be_present
  end

  it 'adds the new version' do
    @theme.versions.length.should == 1
  end

  it 'sets the current version' do
    @theme.current_version.should == @tp.attributes[:version]
  end
end
