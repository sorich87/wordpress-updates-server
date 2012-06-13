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
  field :attachment_file_name
  field :attachment_content_type
  field :attachment_file_size,    :type => Integer
  field :attachment_updated_at,   :type => DateTime

  attr_accessor :screenshot_path_in_zip

  validates_presence_of :version

  embedded_in :extension

  has_attached_file :attachment,
    fog_public: false,
    path: 'extensions/:attachment/:id/:filename'

end
