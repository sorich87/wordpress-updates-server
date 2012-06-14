require 'spec_helper'

describe PluginParser do
  sample_file = File.new( File.join(Rails.root, 'spec/fixtures/plugins/zips/acobot.1.1.2.zip') ) 

  it 'should parse a valid file' do
    plugin_parser = PluginParser.new(sample_file)
    plugin_parser.should be_parsed
  end

  describe 'attributes' do
    plugin_parser = PluginParser.new(sample_file)

    attributes = [:plugin_name, :plugin_uri, :description, :version, 
      :license, :license_uri, :tags, :author]

    attributes.each do |attr|
      it "should respond to #{attr}" do
        plugin_parser.should respond_to(attr)
      end
    end

    specify { plugin_parser.plugin_name.should_not be_nil }
    specify { plugin_parser.plugin_uri.should_not be_nil }
    specify { plugin_parser.description.should_not be_nil }
    specify { plugin_parser.version.should_not be_nil }
    specify { plugin_parser.license.should_not be_nil }
    specify { plugin_parser.tags.should_not be_nil }
    specify { plugin_parser.author.should_not be_nil }

    it 'should have an array of tags' do
      plugin_parser.attributes[:tags].is_a?(Array).should be_true
    end
  end


  describe 'missing attibutes' do
    let(:plugin_parser) do
      file = File.new( File.join(Rails.root, 'spec/fixtures/plugins/zips/invalid/missing_name.zip') ) 
      PluginParser.new(file)
    end

    it 'should mark file as invalid when no name is present' do
      plugin_parser.should_not be_valid
    end

    it 'should add error message to :theme_name when the theme name is missing' do
      plugin_parser.errors.should have_key(:plugin_name)
    end
  end


  # Test all of the downloaded plugins
  describe 'downloaded plugin' do
    plugin_files = File.join(Rails.root, 'spec/fixtures/plugins/zips/*.zip')

    Dir.glob(plugin_files).each do |plugin|
      specify "#{File.basename(plugin)} should be valid" do
        pp = PluginParser.new(plugin)
        pp.should be_parsed

        unless pp.valid?
          puts plugin
        end
        pp.should be_valid
      end

    end
  end
end