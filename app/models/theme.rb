# TODO: Make archives (.zip) private

class Theme < Extension
  alias_attribute :theme_name, :name
  alias_attribute :theme_uri, :uri
  alias_attribute :theme_version, :extension_version # So lazy :)

  def as_json(options={})
    {
      _id:            self.id,
      name:           self.name,
      uri:            self.uri,
      theme_version:  self.theme_version,
      author:         self.author,
      author_uri:     self.author_uri,
      description:    self.description,
      license:        self.license,
      license_uri:    self.license_uri,
      tags:           self.tags,
      status:         self.status,
      template:       self.template,
      screenshot:     self.screenshot.url
    }
  end

  private

  def grab_screenshot_from_zip(zip_file)
    # TODO: Needs testing with Amazon
    return if screenshot_path_in_zip.nil?

    zip = Zip::ZipFile.new(zip_file)
    zip_entry = zip.get_entry(screenshot_path_in_zip)

    filename = screenshot_path_in_zip.split('/')[-1]

    # TODO: Amazon tempdirectory?
    tempname = File.join(Rails.root, 'tmp', "#{DateTime.now.to_i}-#{name}-#{filename}")
    zip_entry.extract(tempname)

    tempfile = File.new(tempname)
    screenshot.assign( tempfile )
    File.delete(tempname)
  end
end
