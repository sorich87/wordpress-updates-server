class ThemeParser < Parser
  FIELDS = [
    :theme_name, :theme_uri, :description, :version,
    :license, :license_uri, :tags, :author, :author_uri,
    :template, :status, :screenshot_path_in_zip
  ]

  REQUIRED_ATTRIBUTES = [:theme_name, :version, :screenshot_path_in_zip]

  def parsed?
    @css_file_parsed
  end

  def valid?
    required_attributes_present?
  end

  private

  def parse_entry(entry)
    if entry.name =~ /^[\w\.-]+\/[^\/]+\.css$/
      extract_headers_from_css(entry)
    elsif entry.name =~ /^[\w\.-]+\/[\w\.-]?screenshot[\w\.-]?\.(png|jpg|jpeg|gif)$/
      @attributes[:screenshot_path_in_zip] = entry.name
    end
  end

  def extract_headers_from_css(entry)
    return if all_attributes_present?

    entry.get_input_stream do |css_file|
      is_comment = false

      css_file.each_with_index do |line, index|
        # If comments haven't started by 60 lines we're probably in the clear
        break if index > 60 && !all_attributes_present?

        line.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '', universal_newline: true)
        line.encode!('UTF-8', 'UTF-16')
        line.strip!

        if line =~ /\/\*.?/ # Start of comments
          is_comment = true
        elsif line =~ /^.?\*\/.?/ # End of comments
          unless index < 60 && all_attributes_present?
            break
          end
        elsif is_comment == true
          attribute = extract_attribute(line)
          @attributes[attribute[0]] = attribute[1] unless attribute.empty?
          @css_file_parsed = true
        end
      end
    end
  end
end