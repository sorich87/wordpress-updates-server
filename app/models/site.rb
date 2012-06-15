class Site
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :customer

  field :domain_name,            :type => String
  field :secret_key,             :type => String
  field :unconfirmed_secret_key, :type => String
  field :confirmation_token,     :type => String
  field :confirmed_at,           :type => Time
  field :confirmation_sent_at,   :type => Time

  index :domain_name, :unique => true
  index :confirmation_token

  validates_presence_of :domain_name
  validates_uniqueness_of :domain_name, scope: :customer_id
  validates :domain_name, format: { with: /^[a-z0-9\-\.]+\.[a-z]{2,}$/i }

  attr_accessible :domain_name

  def confirmed?
    !!self[:confirmed_at]
  end

  def confirm!
    self[:secret_key] = self[:unconfirmed_secret_key]
    self[:unconfirmed_secret_key] = nil
    self[:confirmation_token] = nil
    self[:confirmed_at] = Time.now.utc
    save(:validate => false)
  end

  def send_confirmation_instructions
    generate_confirmation_token
    SiteMailer.confirmation_instructions(self).deliver
    self[:confirmation_sent_at] = Time.now.utc
    save(:validate => false)
  end

  def generate_confirmation_token
    begin
      self[:confirmation_token] = SecureRandom.urlsafe_base64
    end while Site.where(confirmation_token: self[:confirmation_token]).exists?
  end

end
