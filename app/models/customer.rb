class Customer
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :name, :business_name, :email, :telephone_number

  def initialize(attributes = {})
    @name = attributes[:name]
    @business_name = attributes[:business_name]
    @email = attributes[:email]
    @telephone_number = attributes[:telephone_number]
  end

  # def persisted?
  #   false
  # end
end
