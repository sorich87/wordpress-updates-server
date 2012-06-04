require 'sanitize'


class CSSParser
  FIELDS = [
    :theme_name, :theme_uri, :description, :version,
    :license, :license_uri, :tags, :author, :author_uri,
    :template, :status
  ]

  def initialize(filename)
    @@parsed = false
    @@theme = {}
    @@errors = {}

    if filename.is_a? Zip::ZipInputStream
      @@filename = "zipinputstream"
      @@file = filename
      parse_theme
    else File.exists? filename
      @@filename = filename
      @@file = File.new(@@filename, "r")

      parse_theme
    end
  end

  def parse_theme
    is_comment = false
    @@file.each do |line|
      if line.strip =~ /^.?\/\*.?$/ # Start of comments
        is_comment = true
      elsif line.strip =~ /^.?\*\/.?$/ # End of comments
        @@parsed = true
        break
      elsif is_comment == true
        parse_comment(line)
      end
    end

    valid?
  end

  def parse_comment(line)
    # Split the line into what it describes and the value of that
    # http://rubular.com/r/MOGWaxU5Jt
    matches = %r/\s?\*?\s?([a-zA-Z ]*): (.+)/.match(line)

    return if matches.nil?
    
    type = matches[1]
    value = matches[2]

    type = type.downcase.gsub(' ', '_').to_sym
    value = strip(value)

    if type == :tags
      @@theme[:tags] ||= []
      value = value.split(',')
      value.each do |tag|
        @@theme[:tags] << tag.strip
      end
    else
      @@theme[type] = value if FIELDS.include? type
    end
  end

  def attributes
    @@theme if @@theme
  end

  def errors
    @@errors
  end

  def parsed?
    @@parsed
  end

  def method_missing(m)
    if FIELDS.include? m
      @@theme[m]
    else
      super
    end
  end

  def respond_to?(m)
    if FIELDS.include? m
      true
    else
      super
    end
  end

  def valid?
    all_valid = true
    required_fields = [:theme_name]
    required_fields.each do |field|
      if @@theme[field].nil?
        @@errors[field] ||= [] << " must be included."
        all_valid = false
      end
    end

    return all_valid
  end

  private
  
  def strip(line)
    # TODO: Add HTML whitelist
    line.strip!
    Sanitize.clean(line)
  end
end