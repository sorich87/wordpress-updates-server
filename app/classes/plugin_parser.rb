require 'zip/zip'

class PluginParser < Parser
  IGNORED_FILES = [
    /.xml$/,
    /^[\w-]+\/[\w-]+\//,
    /^[\w-]+\/$/,
  ]

  FIELDS = [
    :plugin_name, :plugin_uri, :description, :version,
    :license, :license_uri, :tags, :author, :author_uri,
    :tested_up_to, :requires_at_least, :stable_tag
  ]

  REQUIRED_ATTRIBUTES = [
    :plugin_name, :version
  ]

  def initialize(file)
    if file.is_a? File
      @file = file.path
    elsif File.exists?(file)
      @file = file
    else
      raise ArgumentError, "filename must be an instance of File or a path to a file."
    end

    @FIELDS = FIELDS
    @IGNORED_FILES = IGNORED_FILES
    @REQUIRED_ATTRIBUTES = REQUIRED_ATTRIBUTES
    @parsed = false
    @errors = {}
    @attributes = {}

    @zip = Zip::ZipFile.new(@file)

    parse_plugin
  end

  def parsed?
    if @extracted_readme_headers == false
      puts "readme headers weren't extracted"
    end

    if @extracted_php_headers == false
      puts "php headers weren't extracted"
    end

    @extracted_php_headers && @extracted_readme_headers
  end

  private

  def parse_plugin
    get_zip_files
    get_headers

    @valid = required_attributes_present?
  end

  def get_headers
    @zip_files.each do |zip_file|
      
      if zip_file =~ /^[\w-]+\/[^\/]+\.php$/ # http://rubular.com/r/ARxqDqI7qu
        extract_headers_from_php(zip_file)
      elsif zip_file =~ /^[\w-]+\/(README|readme)\.txt$/ # http://rubular.com/r/Fb5AedD7ub
        extract_headers_from_readme(zip_file)
      end

    end
  end

  def extract_headers_from_php(file_path)
    @extracted_php_headers ||= false
    return if @extracted_php_headers

    get_input_stream file_path do |php_file|
      is_comment = false

      php_file.each_with_index do |line, index|
        # If comments haven't started by 60 lines we're probably in the clear
        break if index > 60 && !is_comment

        if line.strip =~ /^.?\/\*.?$/ # Start of comments
          is_comment = true
        elsif line.strip =~ /^.?\*\/.?$/ # End of comments
          break
        elsif is_comment == true
          attribute = extract_attribute(line)
          unless attribute.empty?
            @attributes[attribute[0]] = attribute[1]
            @extracted_php_headers = true
          end
        end
      end
    end
  end

  def extract_headers_from_readme(file_path)
    @extracted_readme_headers ||= false
    return if @extracted_readme_headers # This is probably never true, but still.

    get_input_stream file_path do |readme_file|
      last_line_was_attribute = false

      readme_file.each_with_index do |line, index|
        break if index > 5 && !last_line_was_attribute

        attribute = extract_attribute(line)
        unless attribute.empty?
          last_line_was_attribute = true
          @extracted_readme_headers = true
          @attributes[attribute[0]] = attribute[1]
        end
      end
    end
  end
end
