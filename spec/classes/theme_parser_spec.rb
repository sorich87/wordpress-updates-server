require 'spec_helper'

describe ThemeParser do  
  describe 'valid zips' do
    zip_files = File.join(Rails.root, 'spec/fixtures/themes/zips/*.zip')

    Dir.glob(zip_files).each do |zip_file|
      it "should mark #{zip_file} as valid" do
        tp = ThemeParser.new(zip_file)
        tp.should be_valid
      end
    end
  end

  describe 'invalid zips' do
    zip_files = File.join(Rails.root, 'spec/fixtures/themes/zips/invalid/*.zip')
    Dir.glob(zip_files).each do |zip_file|
      it "should mark #{zip_file} as invalid" do
        tp = ThemeParser.new(zip_file)
        tp.should_not be_valid
      end
    end

    describe 'error messages' do
      it 'should add an error when screenshot is missing' do
        zip_file = File.join(Rails.root, 'spec/fixtures/themes/zips/invalid/screenshot_missing.zip')
        tp = ThemeParser.new(zip_file)
        tp.errors.should have_key(:screenshot_path_in_zip)
      end

      it 'should add be invalid when style.css is missing' do
        zip_file = File.join(Rails.root, 'spec/fixtures/themes/zips/invalid/style_missing.zip')
        tp = ThemeParser.new(zip_file)
        tp.should_not be_valid
      end
    end
  end

  it 'should get the attributes out of it' do
    @attributes = {
      theme_name:   'Hatch',
      theme_uri:    'http://devpress.com/shop/hatch/',
      description:  'A simple and minimal portfolio theme for photographers, illustrators, designers, '\
                    'or photobloggers. Responsive layout, optimized for mobile browsing (iPhone and iPad). '\
                    'Ideal for sites where images are the main type of content. The customization options '\
                    'include theme settings page, custom background, custom header.',
      version:'0.1.8',
      author:       'Galin Simeonov',
      author_uri:   'http://devpress.com',
      tags:         %w{flexible-width theme-options threaded-comments microformats translation-ready 
                    rtl-language-support one-column two-columns right-sidebar custom-background
                    custom-header featured-images},
      license:      'GNU General Public License v2.0',
      license_uri:  'http://www.gnu.org/licenses/gpl-2.0.html'
    }
    tp = ThemeParser.new(File.join(Rails.root, 'spec/fixtures/themes/zips/hatch.zip'))
    attributes = tp.attributes
    attributes.delete(:screenshot_path_in_zip)
    attributes.should eq(@attributes)
  end
end
