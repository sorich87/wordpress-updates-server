class Package
  include Mongoid::Document

  field :name,          :type => String
  field :description,   :type => String
  field :price,         :type => Float
  field :themes,        :type => Integer
  field :domains,       :type => Integer
  field :billing,       :type => Integer
  field :validity,      :type => Integer

  belongs_to :business
  has_many :customers

  VALIDITY = {
    :lifetime => 0,
    :one_year => 1,
    :one_month => 2
  }

  BILLING = {
    :one_time_payment => 0,
    :subscription => 1
  }

  THEMES = {
    :one_theme => 0,
    :all_themes => 1
  }

  validates_presence_of [:name, :description, :price, :themes, :domains, :billing, :validity, :business]
  
  validates_numericality_of :price, 
    :greater_than_or_equal_to => 0
  
  validates_inclusion_of :validity,
    :in => VALIDITY.values

  validates_inclusion_of :billing,
    :in => BILLING.values

  validates_inclusion_of :themes,
    :in => THEMES.values

  def is_valid_for_life?
    read_attribute(:validity) == VALIDITY[:lifetime]
  end

  def is_subscription?
    read_attribute(:billing) == BILLING[:subscription]
  end

  def self.validity_strings_and_values
    arr = []
    VALIDITY.each do |key, val|
      key = key.to_s.upcase.gsub('_', ' ')
      arr.push([key, val])
    end
    puts arr
    arr
  end
end
