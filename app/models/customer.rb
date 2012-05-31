class Customer
  include Mongoid::Document

  field :first_name,  :type => String
  field :last_name,   :type => String
  field :email,       :type => String

  has_and_belongs_to_many :businesses

  validates :email,
    :presence => true,
    :email => true,
    :uniqueness => { :case_sensitive => false }

  attr_accessible :first_name, :last_name, :email

  def full_name
    "#{first_name} #{last_name}"
  end
end
