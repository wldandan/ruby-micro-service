class Product
  attr_accessor :id, :name, :price, :category, :created_at, :updated_at

  def initialize(attributes={})
    attributes.each do |attribute, value|
      self.instance_variable_set("@#{attribute}", value)
    end
  end
end
