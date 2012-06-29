class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes

  after_initialize :set_expiration_date

  embedded_in :customer
  has_and_belongs_to_many :extensions, inverse_of: nil
  has_one :business

  field :purchase_date,      type: Date
  field :expiration_date,    type: Date
  field :validity,           type: Integer
  field :package_name,       type: String
  field :price,              type: Float
  field :is_subscription,    type: Boolean
  field :number_of_domains,  type: Integer
  field :has_all_extensions, type: Boolean

  scope :current, where(:expiration_date.gt => Date.today)
  scope :expired, where(:expiration_date.lte => Date.today)

  attr_accessible :business_id, :purchase_date, :expiration_date, :extension_ids, :has_all_extensions,
    :package_id, :package, :package_name, :price, :is_subscription, :validity, :number_of_domains

  attr_accessor :package_id, :package

  validates_presence_of :customer, :purchase_date, :package_name
  validates_presence_of :extension_ids, unless: :has_all_extensions

  validates_numericality_of :number_of_domains, greater_than_or_equal_to: 0, only_integers: true
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :validity, greater_than_or_equal_to: 0, only_integers: true

  validate :extensions_validation, on: :save

  def renew_subscription!
    return unless is_subscription
    self[:expiration_date] = expiration_date >> validity unless validity.nil?
    save(validate: false)
  end

  def price
    "%.2f" % read_attribute(:price) unless read_attribute(:price).nil?
  end

  def expired?
    return false if expiration_date.nil?
    return false if ( expiration_date <=> Date.today ) > 0
    return true
  end

  def package=(value)
    self[:package_name] = value[:name]
    self[:price] = value[:price]
    self[:is_subscription] = value[:is_subscription]
    self[:validity] = value[:validity]
    self[:number_of_domains] = value[:number_of_domains]
    self[:has_all_extensions] = value[:has_all_extensions]
  end

  def plugins
    extensions.plugins
  end

  def themes
    extensions.themes
  end

  private

  def set_expiration_date
    return unless expiration_date.nil?
    self[:expiration_date] = purchase_date >> validity unless validity.nil?
  end
end
