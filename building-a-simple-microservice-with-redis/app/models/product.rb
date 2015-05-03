class Product
  attr_accessor :id, :name, :price

  def initialize(id, name, amount)
    self.id = id
    self.name = name
    self.price = amount
  end

end
