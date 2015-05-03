class Products
  attr_accessor :products

  def initialize
    self.products = []
  end

  def count
    products.size
  end

  def <<(product)
    self.products << product
  end

end
