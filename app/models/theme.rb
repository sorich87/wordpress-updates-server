class Theme < Extension

  alias_attribute :theme_name, :name

  private

  def grab_screenshot_from_zip(value)
    zip_file = value[:attachment].tempfile
    screenshot_path_in_zip = value[:screenshot_path_in_zip]
    return if screenshot_path_in_zip.nil?

    zip = Zip::ZipFile.new(zip_file)
    zip_entry = zip.get_entry(screenshot_path_in_zip)

    filename = screenshot_path_in_zip.split('/')[-1]

    tempname = File.join(Rails.root, 'tmp', "#{DateTime.now.to_i}-#{name}-#{filename}")
    zip_entry.extract(tempname)

    tempfile = File.new(tempname)
    screenshot.assign( tempfile )
    File.delete(tempname)
  end
end
