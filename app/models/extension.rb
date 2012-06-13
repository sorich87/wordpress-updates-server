class Extension
  include Mongoid::Document
  include Mongoid::Timestamps
  include Paperclip
  include Paperclip::Glue

  before_save :set_current_version

  field :name,            type: String
  field :current_version, type: String

  # Fields used by Paperclip
  field :screenshot_file_name
  field :screenshot_content_type
  field :screenshot_file_size,    :type => Integer
  field :screenshot_updated_at,   :type => DateTime

  validates_presence_of [:name, :business_id]
  validates_uniqueness_of :name, :scope => :business_id
  validates :name, :on => :update, :immutable => true
  validates :current_version, :version => true

  belongs_to :business
  embeds_many :versions, :cascade_callbacks => true do
    def current
      where(version: @base.current_version).first
    end
  end
  has_and_belongs_to_many :purchases
  has_and_belongs_to_many :packages

  accepts_nested_attributes_for :versions

  has_attached_file :screenshot,
    fog_public: true,
    path: 'extensions/:attachment/:id/:style/:filename'

  alias_attribute :theme_name, :name

  # Interrupt the assignment of the attachment and grab the tempfile
  # so we can extract the screenshot from it.
  def new_version=(value)
    grab_screenshot_from_zip(value)
    versions = versions || []
    versions << value
    self.versions = versions
  end

  def set_current_version
    self.current_version = versions.last.version
  end
end
