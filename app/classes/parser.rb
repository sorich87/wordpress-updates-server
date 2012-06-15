require 'zip/zip' 

class Parser

  FIELDS = []
  REQUIRED_ATTRIBUTES = []

  def initialize(file)
    if file.is_a? File
      file = file.path
    elsif ! File.exists?(file)
      raise ArgumentError, "filename must be an instance of File or a path to a file."
    end

    @FIELDS = self.class::FIELDS
    @REQUIRED_ATTRIBUTES = self.class::REQUIRED_ATTRIBUTES
    @parsed = false
    @errors = {}
    @attributes = {}

    Zip::ZipFile.foreach(file) { |entry| parse_entry(entry) if entry.file? }

    @valid = required_attributes_present?
	end

  def attributes
    @attributes
  end

  def errors
    @errors
  end

  def valid?
    @valid
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

  private

  def strip(line)
    # TODO: Add HTML whitelist
    line.strip!
    # TODO: Figure out a proper way to strip when Nokogiri complains about encoding.
    Sanitize.clean(line)
  end

  def extract_attribute(line)
    matches = line.match(/^\s?\*?\s?(?<attribute>[a-zA-Z ]*):\s?(?<value>.+)$/)
    return [] if matches.nil?

    attribute = matches[:attribute].downcase.gsub(' ', '_').to_sym
    value = strip(matches[:value])

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

  def all_attributes_present?
    @FIELDS.each do |attribute|
      if @attributes[attribute].nil?
        return false
      end
    end
    return true
  end

  def add_error(attribute, error_message)
    @errors[attribute] ||= []
    unless @errors[attribute].include? error_message
      @errors[attribute] << error_message
    end
  end
end
