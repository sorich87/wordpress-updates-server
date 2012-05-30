require 'zip/zip'

class ThemeParser
  REQUIRED_FILES = ['style\.css', 'screenshot\.(png|jpg|jpeg)']

  def initialize(filename)
    @filename = filename
    @zip = Zip::ZipFile.open(@filename)
    valid?
  end


  def valid?
    return false unless validate_required_files
    return false unless validate_css_file

    return true
  end

  def css
    @css_parser
  end

  private
  
  def validate_required_files
    found = 0
    zip_files = []
    Zip::ZipFile.foreach @filename do |file|
      zip_files << file
    end

    REQUIRED_FILES.each do |required_file|
      regex = Regexp.new(required_file)

      zip_files.each do |zip_file|
        if regex.match(zip_file.to_s)
          if zip_file =~ /screenshot\.(png|jpg|jpeg)/
            @screenshot = zip_file
          end

          found += 1
          break
        end
      end
    end

    if found == REQUIRED_FILES.count
      return true
    else
      return false
    end
  end

  def validate_css_file
    css_file_path = ""
    Zip::ZipFile.foreach @filename do |file|
      # The style.css is in the root folder, but that's often
      # one directory deep eg. annotum-base.zip extracts to
      # annotum-base/*files*
      # http://rubular.com/r/7QSg4bY7fx
      if file.to_s =~ /\A[\w-]{0,}\/{0,1}style.css$/
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