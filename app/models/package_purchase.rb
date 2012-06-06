class PackagePurchase
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :customer
  belongs_to :package
  has_and_belongs_to_many :themes

  field :purchase_date, type: Date

  attr_accessible :package, :purchase_date, :themes

  validates_presence_of :customer, :package, :purchase_date, :themes
end
