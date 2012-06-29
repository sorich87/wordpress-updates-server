require 'spec_helper'

describe Plugin do
  let(:business) { Fabricate.build(:business) }

  it 'is valid given a valid file' do
    filename = File.join(Rails.root, 'spec/fixtures/plugins/zips/acobot.1.1.2.zip')
    file = File.new(filename)
    tempfile = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
    pp = PluginParser.new(file)
    plugin = business.extensions.new(name: pp.attributes[:name],
                                     new_version: pp.attributes.merge(archive: tempfile),
                                     _type: 'Plugin')
    plugin.should be_valid
  end
end
