class Business
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :packages
  has_many :users, dependent: :delete
  has_many :extensions, dependent: :delete
  has_and_belongs_to_many :customers

  field :name,      :type => String
  field :email,     :type => String
  field :country,   :type => String
  field :time_zone, :type => String
  field :street1,   :type => String
  field :street2,   :type => String
  field :city,      :type => String
  field :state,     :type => String
  field :zip,       :type => String
  field :phone,     :type => String

  index :email, :unique => true

  validates :email,
    :presence => true,
    :email => true,
    :uniqueness => { :case_sensitive => false }

  validates :name,
    :presence => true,
    :length => {
      :minimum => 2,
      :maximum => 50
    }

  attr_accessible :name, :email, :users, :country, :time_zone, :street1, :street2, :city, :state, :zip, :phone

  def plugins
    extensions.plugins
  end

  def themes
    extensions.themes
  end
end
