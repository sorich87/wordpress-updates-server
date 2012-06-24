class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes

  embedded_in :customer
  has_many :extensions
  has_one :package

  field :purchase_date, type: Date

  attr_accessible :package_id, :purchase_date, :extension_ids

  validates_presence_of :customer, :package_id, :purchase_date, :extension_ids

  def expiration_date
    purchase_date >> package.validity unless package.is_valid_for_life?
  end

  def expired?
    return false if expiration_date.nil?
    return false if ( expiration_date <=> Date.today ) > 0
    return true
  end

  def themes
    extensions.where(_type: "Theme")
  end

  def plugins
    extensions.where(_type: "Plugin")
  end
end
