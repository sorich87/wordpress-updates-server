require 'spec_helper'

describe CSSParser do
  before do
    @fixture_file = File.join( Rails.root, 'spec/fixtures/themes/headers/', 'valid_header.css' )
  end

  it 'should parse a valid CSS file' do
    tp = CSSParser.new( @fixture_file )
    tp.should be_parsed
  end

  describe 'attributes' do
    before do
      @tp = CSSParser.new( @fixture_file )
    end

    attributes = [:theme_name, :theme_uri, :description, :version, :license,
      :license_uri, :tags, :author]

    attributes.each do |attr|
      it "should respond to #{attr}" do
        @tp.should respond_to(attr)
      end
    end

    specify { @tp.theme_name.should_not be_nil }
    specify { @tp.theme_uri.should_not be_nil }
    specify { @tp.description.should_not be_nil }
    specify { @tp.version.should_not be_nil }
    specify { @tp.license.should_not be_nil }
    specify { @tp.license_uri.should_not be_nil }
    specify { @tp.tags.should_not be_nil }
    specify { @tp.author.should_not be_nil }

    it 'should create an array of tags' do
      @tp.tags.is_a?(Array).should be_true
    end
  end

  describe 'missing attibutes' do
    before do
      @header_path = File.join( Rails.root, 'spec/fixtures/themes/headers/')
    end

    it 'should mark file as invalid when no name is present' do
      @tp = CSSParser.new( File.join(@header_path, 'missing_name.css' ))
      @tp.should_not be_valid
    end
  end


  # Test a couple of style.css:s that were downloaded from
  # http://wordpress.org/extend/themes/
  # Basically we just don't want an exception to occur
  describe 'downloaded style' do
    css_files = File.join(Rails.root, 'spec/fixtures/themes/headers/downloaded/*.css')

    Dir.glob(css_files).each do |file|

      specify "#{file} should be valid" do
        tp = CSSParser.new(file)
        tp.should be_valid
      end

    end
  end
  
end

