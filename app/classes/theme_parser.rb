require 'zip/zip'

class ThemeParser
  REQUIRED_FILES = [:style, :screenshot]

  def initialize(filename)
    @filename = filename
    @@errors = {}
    @@required_files = [
      {
        identifier: :style,
        regex: /\A[\.\w-]{0,}\/{0,1}style.css$/
      },
      {
        identifier: :screenshot,
        regex: /screenshot\.(png|jpg|jpeg|gif)/
      }
    ]

    if File.exists?(filename)
      @zip = Zip::ZipFile.open(@filename)
    else
      @@errors[:base] = "File \"#{filename}\" does not exist or is not a file."
    end
    valid?
  end


  def valid?
    return false if @zip.nil?
    return false unless validate_required_files
    return false unless validate_css_file

    return true
  end

  def css
    @css_parser
  end

  def attributes
    css.attributes if css
  end

  def errors
    @@errors
  end

  private
  
  def validate_required_files
    find_files
    all_files_present = true
    @@required_files.each do |required_file|
      unless required_file[:found]
        identifier = required_file[:identifier]
        @@errors[identifier] ||= []
        unless @@errors[identifier].include? "could not be found."
          @@errors[identifier] << "could not be found."
        end
        all_files_present = false
      end
    end

    return all_files_present
  end

  def find_files
    zip_files = []
    Zip::ZipFile.foreach @filename do |file|
      zip_files << file
    end

    @@required_files.each_with_index do |required_file, index|
      regex = required_file[:regex]
      zip_files.each do |zip_file|
        if regex.match(zip_file.to_s)
          @@required_files[index][:found] = true
          @@required_files[index][:location] = zip_file.to_s
          break
        end
      end
    end
  end

  def validate_css_file
    css_file_path = ""
    Zip::ZipFile.foreach @filename do |file|
      # The style.css is in the root folder, but that's often
      # one directory deep eg. annotum-base.zip extracts to
      # annotum-base/*files*
      # http://rubular.com/r/XvC094vi0m
      if file.to_s =~ /\A[\.\w-]{0,}\/{0,1}style.css$/
        css_file_path = file
        break
      end
    end

    # Return false if style.css was not found
    return false unless css_file_path.is_a? Zip::ZipEntry

    css_file = @zip.get_input_stream( css_file_path )
    @css_parser ||= CSSParser.new(css_file)
    @css_parser.valid?
  end
end