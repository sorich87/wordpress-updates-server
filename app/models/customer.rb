class Customer
  include Mongoid::Document

  field :first_name,  :type => String
  field :last_name,   :type => String
  field :email,       :type => String

  belongs_to :business
  has_many :packages

  validates_presence_of [:first_name, :last_name, :email]
  validates :email, :email => true, :uniqueness => true

  def full_name
    "#{first_name} #{last_name}"
  end
end
