class Package
  include Mongoid::Document

  field :name,              :type => String
  field :description,       :type => String
  field :price,             :type => Float
  field :number_of_themes,  :type => Integer
  field :number_of_domains, :type => Integer
  field :billing,           :type => Integer
  field :validity,          :type => Integer

  belongs_to :business
  has_many :package_purchases
  has_and_belongs_to_many :themes

  BILLING = {
    :one_time_payment => 0,
    :subscription => 1
  }

  attr_accessible :name, :description, :price, :number_of_themes, :number_of_domains, :billing, :validity, :theme_ids

  validates_presence_of [:name, :description, :price, :number_of_themes, :number_of_domains, :billing, :validity, :business, :theme_ids]

  validates_numericality_of :number_of_domains, greater_than_or_equal_to: 0, only_integers: true
  validates_numericality_of :number_of_themes, greater_than_or_equal_to: 0, only_integers: true
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :validity, greater_than_or_equal_to: 0, only_integers: true

  validates_inclusion_of :billing,
    :in => BILLING.values

  def is_valid_for_life?
    read_attribute(:validity) == 0
  end

  def is_subscription?
    read_attribute(:billing) == BILLING[:subscription]
  end

  def unlimited?
    read_attribute(:number_of_domains) == 0
  end

  def price
    "%.2f" % read_attribute(:price) unless read_attribute(:price).nil?
  end
end
