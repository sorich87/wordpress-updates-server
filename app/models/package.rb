class Package
  include Mongoid::Document

  field :name,                 :type => String
  field :description,          :type => String
  field :price,                :type => Float
  field :number_of_extensions, :type => Integer
  field :number_of_domains,    :type => Integer
  field :is_subscription,      :type => Boolean
  field :validity,             :type => Integer
  field :has_all_extensions,   :type => Boolean

  alias_attribute :frequency, :validity

  embedded_in :business
  has_and_belongs_to_many :extensions, inverse_of: nil

  attr_accessible :name, :description, :price, :number_of_extensions, :number_of_domains,
    :is_subscription, :validity, :frequency, :extension_ids, :has_all_extensions

  validates_presence_of :name, :description, :price, :number_of_extensions, :number_of_domains, :validity, :business
  validates_presence_of :extension_ids, unless: :has_all_extensions

  validates_numericality_of :number_of_domains, greater_than_or_equal_to: 0, only_integers: true
  validates_numericality_of :number_of_extensions, greater_than_or_equal_to: 0, only_integers: true
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :validity, greater_than_or_equal_to: 0, only_integers: true

  def price
    "%.2f" % read_attribute(:price) unless read_attribute(:price).nil?
  end

  def plugins
    extensions.plugins
  end

  def themes
    extensions.themes
  end
end
