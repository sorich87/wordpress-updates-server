class Package
  include Mongoid::Document

  field :name, :type => String
  field :description, :type => String
  field :price, :type => Float
  field :themes, :type => Integer
  field :domains, :type => Integer
  field :billing, :type => Integer
  field :validity, :type => Integer

  validates_presence_of [:name, :description, :price, :themes, :domains, :billing, :validity]
  validates_numericality_of :price, :greater_than => 0.00

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

  def is_valid_for_life?
    read_attribute(:validity) == VALIDITY[:lifetime]
  end

  def is_subscription?
    read_attribute(:billing) == BILLING[:subscription]
  end
end
