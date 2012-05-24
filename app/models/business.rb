class Business
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :users

  field :business_name, :type => String
  field :account_name, :type => String

  validates_presence_of :business_name, :account_name
  validates_uniqueness_of :account_name, :case_sensitive => false
  validates_length_of :account_name, :minimum => 4, :maximum => 32
  validates_format_of :account_name, :with => /\A[a-z0-9_]+\z/

  attr_accessible :business_name, :account_name, :users

  before_validation :strip_and_downcase_account_name

  protected

  def strip_and_downcase_account_name
    if account_name.present?
      self.account_name = account_name.strip.downcase
    end
  end
end
