# TODO: More validations

class Theme
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Versioning

  field :name,                type: String
  field :uri,                 type: String
  field :author,              type: String
  field :author_uri,          type: String
  field :description,         type: String
  field :theme_version,       type: String
  field :license,             type: String
  field :license_uri,         type: String
  field :tags,                type: Array
  field :status,              type: String
  field :template,            type: String
  

  validates_presence_of [:name, :theme_version, :business_id]
  validates_uniqueness_of :name, :scope => :business_id

  belongs_to :business
  has_and_belongs_to_many :packages

  has_mongoid_attached_file :archive
  has_mongoid_attached_file :screenshot

  alias_attribute :theme_name, :name
  alias_attribute :theme_uri, :uri

  attr_accessor :screenshot_path_in_zip

  # Interrupt the assignment of the attachment and grab the tempfile
  # so we can extract the screenshot from it.
  def archive=(value)
    grab_screenshot_from_zip(value.tempfile)
    archive.assign(value)
  end

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
    screenshot.save

    File.delete(tempname)
  end
end
