class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :token_authenticatable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ''
  field :encrypted_password, :type => String, :null => false, :default => ''

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  field :authentication_token, :type => String

  include Mongoid::Timestamps

  belongs_to :business, :validate => true

  index :email, :unique => true

  field :first_name, :type => String
  field :last_name,  :type => String

  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :business

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
