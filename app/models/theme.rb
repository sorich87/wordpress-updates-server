class Theme
  include Mongoid::Document
  include Mongoid::Paperclip

  field :name,          type: String
  field :uri,           type: String
  field :description,   type: String
  field :version,       type: String
  field :license,       type: String
  field :license_uri,   type: String
  field :tags,          type: Array

  validates_presence_of [:name]

  belongs_to :business
  has_many :packages

  has_mongoid_attached_file :compressed_file
end
