class Products
  attr_accessor :products

  def initialize
    @products = []
  end

  def count
    @products.size
  end

  def <<(product)
    @products << product
  end
end
