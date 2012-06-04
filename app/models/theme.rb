# TODO: Grab screenshot from .zipfile
# TODO: Handle revisions
# TODO: More validations

class Theme
  include Mongoid::Document
  include Mongoid::Paperclip

  field :name,                type: String
  field :uri,                 type: String
  field :author,              type: String
  field :author_uri,          type: String
  field :description,         type: String
  field :version,             type: String
  field :license,             type: String
  field :license_uri,         type: String
  field :tags,                type: Array
  field :status,              type: String
  field :template,            type: String
  

  validates_presence_of [:name, :version, :business_id]
  validates_uniqueness_of :name, :scope => :business_id

  belongs_to :business
  has_many :packages

  has_mongoid_attached_file :compressed_file

  alias_attribute :theme_name, :name
  alias_attribute :theme_uri, :uri
end
