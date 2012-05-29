class Business
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :users
  has_many :packages
  has_many :customers

  field :name, :type => String
  field :email, :type => String

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

  attr_accessible :name, :email, :users
end
