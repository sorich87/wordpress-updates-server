class Version
  include Mongoid::Document
  include Mongoid::Timestamps
  include Paperclip
  include Paperclip::Glue

  field :uri,         type: String
  field :version,     type: String
  field :author,      type: String
  field :author_uri,  type: String
  field :description, type: String
  field :license,     type: String
  field :license_uri, type: String

  # Theme only fields
  field :tags,        type: Array
  field :status,      type: String
  field :template,    type: String

  # Plugin only fields
  field :domain_path, type: String
  field :network,     type: String
  field :text_domain, type: String

  # Fields used by Paperclip
  field :archive_file_name
  field :archive_content_type
  field :archive_file_size,    :type => Integer
  field :archive_updated_at,   :type => DateTime

  attr_accessor :screenshot_path_in_zip

  has_attached_file :archive,
    fog_public: false,
    path: 'extensions/:attachment/:id/:filename'

  embedded_in :extension

  validates_presence_of :version
  validates_attachment_presence :archive

  attr_accessible :uri, :version, :author, :author_uri, :description, :license, :license_uri,
    :tags, :status, :template, :domain_path, :network, :text_domain, :extension,
    :archive_file_name, :archive_content_type, :archive_file_size, :archive_updated_at, :archive

  def download_url(expires = nil)
    expires ||= 12.hours.from_now
    url = archive.send(:directory).files.get_https_url(archive.path, expires)
  end

end
