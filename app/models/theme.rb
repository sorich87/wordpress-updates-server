# TODO: Make archives (.zip) private

class Theme
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Versioning
  include Mongoid::Timestamps::Created

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
  field :access_token,        type: String
  

  validates_presence_of [:name, :theme_version, :business_id]
  validates_uniqueness_of :name, :scope => :business_id
  validates :name, :on => :update, :immutable => true

  belongs_to :business
  has_and_belongs_to_many :purchases
  has_and_belongs_to_many :packages

  # TODO: Make private.
  # TODO: Files should not be preserved when theme is deleted.
  #       This serves to preserve them when a new version is added.
  has_mongoid_attached_file :archive,
        :url => '/system/themes/:access_token/:version/archive.:extension',
        :path => ':rails_root/public/system/themes/:access_token/:version/archive.:extension',
        :preserve_files => true
  has_mongoid_attached_file :screenshot,
        :url => '/system/themes/:access_token/:version/screenshot.:extension',
        :path => ':rails_root/public/system/themes/:access_token/:version/screenshot.:extension',
        :preserve_files => true

  # We need the access token to be generated immediately when a
  # new record is created, but only when it's a new record.
  before_create :generate_access_token

  alias_attribute :theme_name, :name
  alias_attribute :theme_uri, :uri

  attr_accessor :screenshot_path_in_zip

  # So :url and :path are evaluated at different times, thus
  # the solution is to use two different interpolations.
  # How hacky! And so simple...
  Paperclip.interpolates :path_version  do |attachment, style| 
    if attachment.instance.new_record?
      1
    else
      attachment.instance.version+1
    end
  end
  
  Paperclip.interpolates :version do |attachment, style|
    attachment.instance.version
  end

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

  # Get older versions than <Theme>
  # Has to be called on the parent Theme, as older versions
  # have no access to their parents.
  def get_older_versions_than(instance)

    if instance.version > self.version

      []
    elsif instance.version <= self.version
      
      older_versions = versions.to_a.select {|v| 
        v.version < instance.version 
      }.sort! { |a, b| 
        a.version <=> b.version 
      }.reverse!
    end
  end

  # Get newer versions than <Theme>
  # Has to be called on the parent Theme, as older versions
  # have no access to their parents.
  def get_newer_versions_than(instance)
    if instance.version >= self.version
      []
    elsif instance.version < self.version
      newer_versions = versions.to_a.select {|v| v.version > instance.version }
      newer_versions << self
      newer_versions.sort! { |a, b| a.version <=> b.version }.reverse!
    end
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

  def random_salt(len = 20)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    salt = ""
    1.upto(len) { |i| salt << chars[rand(chars.size-1)] }
    return salt
  end

  # SHA1 from random salt and time
  def generate_access_token
    self.access_token = Digest::SHA1.hexdigest("#{random_salt}#{business_id}#{Time.now.to_i}")
  end

  # interpolate in paperclip
  Paperclip.interpolates :access_token  do |attachment, style|
    attachment.instance.access_token
  end
end
