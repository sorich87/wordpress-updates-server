class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes

  belongs_to :customer
  belongs_to :package
  has_and_belongs_to_many :extensions

  field :purchase_date, type: Date

  attr_accessible :package_id, :purchase_date, :theme_ids

  validates_presence_of :customer, :package_id, :purchase_date

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
