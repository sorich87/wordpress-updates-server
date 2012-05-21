class Business
  include Mongoid::Document
  include ActiveModel::Validations

  field :name, :type => String
  field :email, :type => String

  validates :email,
    :presence => true,
    :email => true,
    :uniqueness => true

  validates :name,
    :presence => true,
    :length => {
      :minimum => 2,
      :maximum => 50
    },
    :uniqueness => true


end
