require 'sequel'

class ProductRepository
  class << self
    def all
      records.each_with_object([]) do |product, products|
        products << Product.new(product)
      end
    end

    def create(name, category, price)
      id = records.insert(name: name, price: price, category: category, created_at: Time.now)
      raise ServiceException, 'Create Product failed' unless id
      records[id: id]
    end

    def find(id)
      product = records[id: id]
      raise ServiceException, 'Product not found' unless product
      product
    end

    def update(id, name, price)
      records.where('id = ?', id).update(name: name, price: price, updated_at: Time.now)
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
