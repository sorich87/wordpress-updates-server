class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes

  before_create :set_expiration_date

  embedded_in :customer
  has_and_belongs_to_many :extensions, inverse_of: nil do
    def themes
      where(_type: 'Theme')
    end

    def plugins
      where(_type: 'Plugin')
    end
  end
  has_one :business

  field :purchase_date,     type: Date
  field :expiration_date,   type: Date
  field :validity,          type: Integer
  field :package_name,      type: String
  field :price,             type: Float
  field :is_subscription,   type: Boolean
  field :number_of_domains, type: Integer

  attr_accessible :business_id, :purchase_date, :expiration_date, :extension_ids, :package_id, :package, :package_name, :price, :is_subscription, :validity, :number_of_domains

  attr_accessor :package_id, :package

  validates_presence_of :customer, :purchase_date, :extension_ids, :package_id

  def renew
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
  end

  def plugins
    extensions.plugins
  end

  def themes
    extensions.themes
  end

  private

  def set_expiration_date
    self[:expiration_date] = purchase_date >> self[:validity] unless self[:validity].nil?
  end
end
