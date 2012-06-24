require 'spec_helper'

describe Plugin do
  let(:business) { Fabricate.build(:business) }

  describe 'grabbing screenshots from archives' do
    it 'should be a valid theme' do
      filename = File.join(Rails.root, 'spec/fixtures/plugins/zips/acobot.1.1.2.zip')
      file = File.new(filename)
      tempfile = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
      pp = PluginParser.new(file)
      plugin = business.plugins.new(name: pp.attributes[:name],
                                    new_version: pp.attributes.merge(archive: tempfile))
      plugin.screenshot.should be_present
    end
  end
end
