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

  index :email, :unique => true
  index :authentication_token

  embeds_many :sites
  embeds_many :purchases do
    def find_by_business(business)
      if business.nil? then all else where(business_id: business.id) end
    end
  end
  has_and_belongs_to_many :businesses

  accepts_nested_attributes_for :purchases
  accepts_nested_attributes_for :sites

  validates :email,
    :presence => true,
    :email => true,
    :uniqueness => { case_sensitive: false, scope: :business_ids }

  attr_accessible :first_name, :last_name, :email

  def full_name
    "#{first_name} #{last_name}"
  end

  def package_names(business = nil)
    purchases.find_by_business(business).current.collect { |p| p.package_name }.uniq
  end

  def extensions(business = nil)
    purchases.find_by_business(business).current.collect do |p|
      if p.has_all_extensions
        unless business.nil? then business.extensions else p.business.extensions end
      else
        p.extensions
      end
    end.flatten
  end

  def plugins(business = nil)
    purchases.find_by_business(business).current.collect do |p|
      if p.has_all_extensions
        unless business.nil? then business.plugins else p.business.plugins end
      else
        p.plugins
      end
    end.flatten
  end

  def themes(business = nil)
    purchases.find_by_business(business).current.collect do |p|
      if p.has_all_extensions
        unless business.nil? then business.themes else p.business.themes end
      else
        p.themes
      end
    end.flatten
  end

  def extension_names(business = nil)
    extensions(business).collect { |e| e.name }.uniq
  end

  def plugin_names(business = nil)
    plugins(business).collect { |p| p.name }.uniq
  end

  def theme_names(business = nil)
    themes(business).collect { |t| t.name }.uniq
  end
end
