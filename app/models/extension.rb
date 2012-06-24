class Extension
  include Mongoid::Document
  include Mongoid::Timestamps
  include Paperclip
  include Paperclip::Glue

  before_validation :set_current_version

  field :name,            type: String
  field :current_version, type: String

  # Fields used by Paperclip
  field :screenshot_file_name
  field :screenshot_content_type
  field :screenshot_file_size,    :type => Integer
  field :screenshot_updated_at,   :type => DateTime

  has_attached_file :screenshot,
    styles: { thumb: '320x240>' },
    fog_public: true,
    path: 'extensions/:attachment/:id/:style/:filename'

  validates_presence_of [:name, :current_version, :business, :versions]
  validates_uniqueness_of :name, :scope => :business_id
  validates :name, :on => :update, :immutable => true
  validates :current_version, :version => true
  validates_attachment_presence :screenshot
  validates_attachment_content_type :screenshot, content_type: ['image/gif', 'image/jpeg', 'image/png']

  belongs_to :business
  embeds_many :versions, :cascade_callbacks => true do
    def current
      where(version: @base.current_version).first
    end
  end

  accepts_nested_attributes_for :versions

  def download_url(version = nil, expires = nil)
    version ||= versions.current
    version = versions.where(version: version).first unless version.is_a?(Version)
    version.download_url(expires)
  end

  # Interrupt the assignment of the attachment and grab the tempfile
  # so we can extract the screenshot from it.
  def new_version=(value)
    grab_screenshot_from_zip(value)
    self.versions.new(value)
  end

  def send_permission_notification(customer)
    ExtensionMailer.permission_notification(self, customer).deliver
  end

  # create a method with each attribute of the current version
  %w(uri author author_uri description license license_uri tags status template domain_path network text_domain).each do |m|
    define_method(m) { versions.current[m] }
  end

  def for_update
    {
      package: download_url,
      new_version: current_version,
      url: uri,
      slug: id
    }
  end

  private

  def set_current_version
    self[:current_version] = self.versions.last.version unless current_version_changed? || self.versions.empty?
  end

  def grab_screenshot_from_zip(value)
    zip_file = value[:archive].tempfile
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
