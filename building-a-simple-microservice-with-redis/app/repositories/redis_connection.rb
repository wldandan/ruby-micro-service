require 'json'
require 'redis'

class RedisConnection

  def self.client
    Redis.new(host: credentials['hostname'], port: credentials['port'], password: credentials['password'])
  end

  private

  def self.credentials
    @credentials ||= fetch_credentials
  end

  def self.fetch_credentials
    credentials = {'credentials'=>{'port'=>'6379', 'hostname'=>'localhost', 'password'=>''}}
    if ENV['VCAP_SERVICES']
      services = JSON.parse(ENV['VCAP_SERVICES'])
      redis_service = services['redis-2.6']
      credentials = redis_service.first['credentials'] if redis_service
    end
    credentials
  rescue Exception => e
    $stderr.puts 'Error in config'
    $stderr.puts "Error: #{e.message}"
  end

end