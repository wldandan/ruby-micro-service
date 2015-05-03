require 'singleton'

class Database
  include Singleton

  def self.instance
    @db ||= setup
  end

  private

  def self.setup
    Sequel.connect('mysql2://127.0.0.1/micro_service', user: 'root', password: '')
    # Sequel.connect(ServiceConfig.db_url, user: ServiceConfig.db_user, password: ServiceConfig.db_password)
  end
end
