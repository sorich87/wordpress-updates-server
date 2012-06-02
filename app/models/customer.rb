class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :token_authenticatable, :trackable

  ## Token authenticatable
  field :authentication_token, :type => String

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :first_name,  :type => String
  field :last_name,   :type => String
  field :email,       :type => String

  has_and_belongs_to_many :businesses
  has_many :sites, dependent: :delete

  validates :email,
    :presence => true,
    :email => true,
    :uniqueness => { :case_sensitive => false }

  attr_accessible :first_name, :last_name, :email

  def full_name
    "#{first_name} #{last_name}"
  end
end
