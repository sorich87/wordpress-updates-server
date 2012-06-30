require 'spec_helper'

describe Plugin do
  let(:business) { Fabricate.build(:business) }

  before(:all) do
    filename = File.join(Rails.root, 'spec/fixtures/plugins/zips/acobot.1.1.2.zip')
    file = File.new(filename)
    tempfile = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
    @pp = PluginParser.new(file)
    @plugin = business.extensions.new(name: @pp.attributes[:name],
                                     new_version: @pp.attributes.merge(archive: tempfile),
                                     _type: 'Plugin')
  end

  it 'is valid given a valid file' do
    @plugin.should be_valid
  end

  it 'adds the screenshot' do
    @plugin.screenshot.should be_present
  end

  it 'adds the new version' do
    @plugin.versions.length.should == 1
  end

  it 'sets the current version' do
    @plugin.current_version.should == @pp.attributes[:version]
  end
end
