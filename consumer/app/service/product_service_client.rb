require 'httparty'

class ProductServiceClient
  include HTTParty
  base_uri 'http://test-product-service.com'

  def get_products
    JSON.parse(self.class.get("/products").body)
  end

  def get_product(id)
    JSON.parse(self.class.get("/products/#{id}").body)
  end
end