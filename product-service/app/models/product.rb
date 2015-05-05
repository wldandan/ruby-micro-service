class Product
  attr_accessor :id, :name, :category, :price

  def initialize(id, name, price)
    self.id = id
    self.name = name
    self.price = price
  end
end
