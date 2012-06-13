class Extension
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Versioning
  include Mongoid::Timestamps::Created

  field :name,                type: String
  field :uri,                 type: String
  field :author,              type: String
  field :author_uri,          type: String
  field :description,         type: String
  field :extension_version,   type: String
  field :license,             type: String
  field :license_uri,         type: String
  field :tags,                type: Array
  field :status,              type: String
  field :template,            type: String
  field :access_token,        type: String
  field :active,              type: Boolean,   default: true

  belongs_to :business
  has_and_belongs_to_many :purchases
  has_and_belongs_to_many :packages

  validates_presence_of [:name, :extension_version, :business_id]
  validates_uniqueness_of :name, :scope => :business_id
  validates :name, :on => :update, :immutable => true
  validates :extension_version, :version => true

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

  attr_accessor :screenshot_path_in_zip
  Paperclip.interpolates :version do |attachment, style|
    attachment.instance.version
  end

  Paperclip.interpolates :access_token do |attachment, style|
    attachment.instance.access_token
  end

  # Interrupt the assignment of the attachment and grab the tempfile
  # so we can extract the screenshot from it.
  def archive=(value)
    grab_screenshot_from_zip(value.tempfile)
    archive.assign(value)
  end

  # Get older versions than <Extension>
  # Has to be called on the parent Extension, 
  # as older versions have no access to their parents.
  # <Extension> can either be an instance or a fixnum (version number)
  # Set include_deleted to true to also include versions marked as destroyed.
  # Returns an array with newer versions
  def get_older_versions_than(requested_version, include_deleted = false)
    requested_version = requested_version.is_a?(Extension) ? requested_version.version 
                                                       : requested_version
    if requested_version <= self.version.to_i
      older_versions = versions.to_a.select {|v| 
        v.active? && v.version < requested_version
      }.sort! { |a, b| 
        a.version <=> b.version 
      }.reverse!
    else
      []
    end
  end

  # Get newer versions than <Extension>
  # Same param/return as get_older_versions_than
  def get_newer_versions_than(version, include_deleted = false)
    version = version.is_a?(Extension) ? version.version : version
    if version < self.version
      newer_versions = versions.to_a.select {|v| v.active? && v.version > version }
      newer_versions << self if self.active?
      newer_versions.sort! { |a, b| a.version <=> b.version }.reverse!
    else
      []
    end
  end

  # Get requested_version <requested_version>
  # <requested_version> can either be a Fixnum or a Theme
  # Set include_deleted to true to include versions marked as deleted
  # Returns an instance of Theme or nil
  def get_version(requested_version, include_deleted = false)
    requested_version = requested_version.theme_version if requested_version.is_a? Theme
    if requested_version == self.version.to_i && self.active?
      return self
    elsif requested_version < self.version
      return versions.to_a.find { |instance| 
        instance.version == requested_version && instance.active?
      }
    end
    nil
  end

  # <requested_version> can either be a Fixnum or a Theme
  # Returns true when version has been deleted, or false if version was not found.
  def deactivate_version!(requested_version)
    instance = requested_version.is_a?(Theme) ? requested_version : get_version(requested_version)
    return false unless instance
    instance.deactivate!
  end

  def deactivate!
    self.active = false
    self.save
  end

  def active?
    self.active
  end

  private

  def version_number_is_higher
    new_version = theme_version.split('.')
    old_version = theme_version_was.split('.')

    new_version.each_index do |i|
      if !old_version[i].nil? && new_version[i].to_i < old_version[i].to_i
        errors.add(:theme_version, :not_higher_version_number)
      else
        break
      end
    end
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
end