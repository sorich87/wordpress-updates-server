class Parser

  FIELDS = []
  ALIASES = {}
  REQUIRED_ATTRIBUTES = [:name, :version, :screenshot_path_in_zip]

  def initialize(file)
    if file.is_a? File
      file = file.path
    elsif ! File.exists?(file)
      raise ArgumentError, "filename must be an instance of File or a path to a file."
    end

    @FIELDS = self.class::FIELDS
    @REQUIRED_ATTRIBUTES = self.class::REQUIRED_ATTRIBUTES
    @ALIASES = self.class::ALIASES
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
    if @FIELDS.include?(attribute)
      if attribute == :tags
        val = []
        value = value.split(',')
        value.each do |tag|
          val << tag.strip
        end
        value = val
      end

      attribute = @ALIASES[attribute] if @ALIASES.keys.include?(attribute)

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
