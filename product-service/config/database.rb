require 'singleton'

class Database
  include Singleton

  def self.instance
    @db ||= setup
  end

  def self.setup
    Sequel.connect(ServiceConfig.db_url, user: ServiceConfig.db_user, password: ServiceConfig.db_password)
  end
end
