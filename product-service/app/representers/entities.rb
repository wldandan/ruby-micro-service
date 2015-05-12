module Entities
  class Product < Grape::Entity
    expose :id, documentation: { type: 'string', desc: 'ID of product.', required: false }
    expose :name, documentation: { type: 'string', desc: 'Name of product.', required: false }
    expose :category, documentation: { type: 'string', desc: 'Category of product.', required: false }
    expose :price, documentation: { type: 'float', desc: 'Price of product.', required: false }
    expose :created_at, documentation: { type: 'float', desc: 'Price of product.', required: false }
    expose :updated_at, documentation: { type: 'float', desc: 'Price of product.', required: false }
  end
end
