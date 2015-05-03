require_relative 'redis_connection'
require 'json'

class ProductRepository

  Client = ::RedisConnection.client

  HASH_KEY = 'products_data'

  def self.fetch_all
    data = Client.hgetall HASH_KEY
    data.each_with_object Products.new do |(id, value), products|
      product = JSON.parse(value)
      products << ::Product.new(id, product['name'], product['price'].to_f)
    end
  end

  def self.read(id)
    data = Client.hget HASH_KEY, id
    if data
      product = JSON.parse(data)
      ::Product.new(id, product['name'], product['price'].to_f)
    end
  end

  def self.create(name, price)
    id = SecureRandom.uuid
    Client.hset HASH_KEY, id, {name: name, price: price}.to_json
    ::Product.new(id, name, price.to_f)
  end

  def self.update(id, name, price)
    Client.hset HASH_KEY, id, {name: name, price: price}.to_json
    ::Product.new(id, name, price.to_f)
  end

  def self.delete(id)
    Client.hdel HASH_KEY, id
    rescue
      false
    true
  end

end
