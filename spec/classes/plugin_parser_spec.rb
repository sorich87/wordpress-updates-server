require 'spec_helper'

describe PluginParser do
  sample_file = File.new( File.join(Rails.root, 'spec/fixtures/plugins/zips/acobot.1.1.2.zip') ) 

  it 'should parse a valid file' do
    plugin_parser = PluginParser.new(sample_file)
    plugin_parser.should be_parsed
  end

  describe 'attributes' do
    plugin_parser = PluginParser.new(sample_file)

    attributes = [:name, :uri, :description, :version, 
      :license, :license_uri, :tags, :author]

    specify { plugin_parser.attributes[:name].should_not be_nil }
    specify { plugin_parser.attributes[:uri].should_not be_nil }
    specify { plugin_parser.attributes[:description].should_not be_nil }
    specify { plugin_parser.attributes[:version].should_not be_nil }
    specify { plugin_parser.attributes[:license].should_not be_nil }
    specify { plugin_parser.attributes[:tags].should_not be_nil }
    specify { plugin_parser.attributes[:author].should_not be_nil }

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

    it 'should add error message to :name when the name is missing' do
      plugin_parser.errors.should have_key(:name)
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
