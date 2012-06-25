class Package
  include Mongoid::Document

  field :name,                 :type => String
  field :description,          :type => String
  field :price,                :type => Float
  field :number_of_extensions, :type => Integer
  field :number_of_domains,    :type => Integer
  field :billing,              :type => Integer
  field :validity,             :type => Integer

  alias_attribute :frequency, :validity

  embedded_in :business
  has_and_belongs_to_many :extensions, inverse_of: nil do
    def themes
      where(_type: 'Theme')
    end

    def plugins
      where(_type: 'Plugin')
    end
  end

  BILLING = {
    :one_time_payment => 0,
    :subscription => 1
  }

  attr_accessible :name, :description, :price, :number_of_extensions, :number_of_domains, :billing, :validity, :frequency, :extension_ids

  validates_presence_of [:name, :description, :price, :number_of_extensions, :number_of_domains, :billing, :validity, :business, :extension_ids]

  validates_numericality_of :number_of_domains, greater_than_or_equal_to: 0, only_integers: true
  validates_numericality_of :number_of_extensions, greater_than_or_equal_to: 0, only_integers: true
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :validity, greater_than_or_equal_to: 0, only_integers: true

  validates_inclusion_of :billing,
    :in => BILLING.values

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
