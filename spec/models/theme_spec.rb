require 'spec_helper'

describe Theme do
  before do
    @business = FactoryGirl.create(:business)
  end

  describe 'grabbing screenshots form archives' do
    it 'should be a valid theme' do
      filename = File.join(Rails.root, 'spec/fixtures/themes/zips/annotum-base.zip')
      file = File.new(filename)
      tempfile = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
      tp = ThemeParser.new(file)
      theme = @business.themes.new( name: tp.attributes[:theme_name],
                                        new_version: tp.attributes.merge(attachment: tempfile) )
      theme.screenshot.should be_present
    end
  end
end
