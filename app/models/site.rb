class Site
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :customer

  field :domain_name,            :type => String
  field :secret_key,             :type => String
  field :unconfirmed_secret_key, :type => String
  field :confirmation_token,     :type => String
  field :confirmed_at,           :type => Time
  field :confirmation_sent_at,   :type => Time

  validates_presence_of :domain_name
  validates_uniqueness_of :domain_name
  validates :domain_name, format: { with: /^[a-z0-9\-\.]+\.[a-z]{2,}$/i }

  attr_accessible :domain_name

  def confirmed?
    !!self[:confirmed_at]
  end

  def confirm!
    self[:secret_key] = self[:unconfirmed_secret_key]
    self[:unconfirmed_secret_key] = nil
    self[:confirmation_token] = nil
    self[:confirmation_sent_at] = nil
    self[:confirmed_at] = Time.now.utc
    save(:validate => false)
  end

  def send_confirmation_instructions
    generate_confirmation_token
    self[:confirmation_sent_at] = Time.now.utc
    save(:validate => false)
    SiteMailer.confirmation_instructions(self).deliver
  end

  def generate_confirmation_token
    begin
      self[:confirmation_token] = SecureRandom.urlsafe_base64
    end while Customer.where({"sites.confirmation_token" => self[:confirmation_token]}).exists?
  end

end
