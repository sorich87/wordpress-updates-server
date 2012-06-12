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

  belongs_to :business
  has_and_belongs_to_many :purchases
  has_and_belongs_to_many :packages

  validates_presence_of [:name, :extension_version, :business_id]
  validates_uniqueness_of :name, :scope => :business_id
  validates :name, :on => :update, :immutable => true
  validates :extension_version, :version => true
end