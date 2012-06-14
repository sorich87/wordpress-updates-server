require 'zip/zip' 

class Parser
  def attributes
    @attributes
  end

  def errors
    @errors
  end

  def strip(line)
    # TODO: Add HTML whitelist
    line.strip!
    Sanitize.clean(line)
  end

  def get_input_stream(file_path, &block)
    
    entry = @zip.get_entry(file_path)
    input_stream = entry.get_input_stream
    input_stream.rewind

    yield input_stream

    @zip.close
  end

  def get_zip_files 
    @zip_files = []
    @zip.each do |zip_file|
      add_file = true

      unless @IGNORED_FILES.nil?
        @IGNORED_FILES.each do |regex|
          if regex =~ zip_file.to_s
            add_file = false
            break
          end
        end
      end

      @zip_files << zip_file.to_s if add_file
    end
  end

  def extract_attribute(line)
    matches = line.match(/^\s?\*?\s?(?<attribute>[a-zA-Z ]*): (?<value>.+)$/)
    return [] if matches.nil?

    attribute = matches[:attribute].downcase.gsub(' ', '_').to_sym
    value = strip(matches[:value].force_encoding("UTF-8"))

    ret = []
    if attribute == :tags and @FIELDS.include? attribute
      val = []
      value = value.split(',')
      value.each do |tag|
        val << tag.strip
      end
      ret << attribute
      ret << val
    elsif @FIELDS.include? attribute
      ret << attribute
      ret << value
    end

    return ret
  end

  def valid?
    required_attributes_present?
  end

  def required_attributes_present?
    all_present = true
    @REQUIRED_ATTRIBUTES.each do |attribute|
      if @attributes[attribute].nil?
        add_error(attribute, "cannot be blank")
        all_present = false
      end
    end
    all_present
  end

  def add_error(attribute, error_message)
    @errors[attribute] ||= []
    unless @errors[attribute].include? error_message
      @errors[attribute] << error_message
    end
  end

  def method_missing(m)
    if @FIELDS.include? m.to_sym
      @attributes[m.to_sym]
    else
      super
    end
  end

  def respond_to?(m)
    if @FIELDS.include? m
      true
    else
      super
    end
  end
end