class Business
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :users
  has_many :packages
  has_many :customers

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
end
