module Entities
  class Product < Grape::Entity
    expose :id, documentation: { type: 'string', desc: 'ID of product.', required: true }, unless: { type: :new }
    expose :name, documentation: { type: 'string', desc: 'Name of product.', required: false }
    expose :price, documentation: { type: 'float', desc: 'Price of product.', required: false }
  end

  class Products < Grape::Entity
    expose :count, documentation: { type: 'integer', desc: 'Total number of products.' }
    expose :products, documentation: { type: 'product', desc: 'All products.', is_array: true }
  end
end
