require 'spec_helper'

describe Plugin do
  before do
    @business = FactoryGirl.create(:business)
  end

  describe 'grabbing screenshots form archives' do
    it 'should be a valid theme' do
      filename = File.join(Rails.root, 'spec/fixtures/plugins/zips/acobot.1.1.2.zip')
      file = File.new(filename)
      tempfile = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
      pp = PluginParser.new(file)
      plugin = @business.plugins.new( name: pp.attributes[:theme_name],
                                        new_version: pp.attributes.merge(attachment: tempfile) )
      plugin.screenshot.should be_present
    end
  end
end
