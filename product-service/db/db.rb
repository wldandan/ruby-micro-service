require 'sequel'
require 'mysql2'
require_relative '../app/service_config'

class DB
  def self.connection
    @db ||= setup_database
  end

  def self.setup_database
    db_user   = ServiceConfig.db_user
    db_pass   = ServiceConfig.db_password
    db_url  = ServiceConfig.db_url
    db_host   = ENV['DB_HOST']
    db_name = ENV['DB_NAME']

    client = Mysql2::Client.new(host: db_host, username: db_user, password: db_pass)
    client.query("drop database if exists #{db_name}")
    client.query("create database #{db_name}")
    client.close

    Sequel.connect(db_url, user: db_user, password: db_pass)
  end
end
