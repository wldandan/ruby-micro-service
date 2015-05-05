require 'sequel'

class ProductRepository
  class << self
    def all
      records.each_with_object Products.new do |product, products|
        products << Product.new(product[:id], product[:name], product[:price].to_f)
      end
    end

    def create(name, price)
      id = records.insert(name: name, price: price)
      raise ServiceException, 'Create Product failed' unless id
      Product.new(id, name, price)
    end

    def find(id)
      product = records[id: id]
      raise ServiceException, 'Product not found' unless product
      product
    end

    def update(id, name, price)
      records.where('id = ?', id).update(name: name, price: price)
    end

    def delete(id)
      records.where('id = ?', id).delete
    end

    private

    def records
      db[:products]
    end

    def db
      Database.instance
    end
  end
end
