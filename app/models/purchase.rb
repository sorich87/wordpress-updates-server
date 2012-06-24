class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes

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
  field :package_name,      type: String
  field :price,             type: Float
  field :billing,           type: Integer
  field :validity,          type: Integer
  field :number_of_domains, type: Integer

  attr_accessible :business_id, :purchase_date, :extension_ids, :package, :package_name, :price, :billing, :validity, :number_of_domains

  attr_accessor :package_id, :package

  validates_presence_of :customer, :purchase_date, :extension_ids

  def expiration_date
    purchase_date >> validity unless validity.nil?
  end

  def expired?
    return false if expiration_date.nil?
    return false if ( expiration_date <=> Date.today ) > 0
    return true
  end

  def package=(value)
    self[:package_name] = value[:name]
    self[:price] = value[:price]
    self[:billing] = value[:billing]
    self[:validity] = value[:validity]
    self[:number_of_domains] = value[:number_of_domains]
  end

  def plugins
    extensions.plugins
  end

  def themes
    extensions.themes
  end
end
