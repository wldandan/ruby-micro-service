$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'service_config'
require 'logging'
require_relative '../config/database'

%w(exceptions models repositories services).each do |folder|
  Dir["#{ServiceConfig.root_path}/app/#{folder}/*.rb"].each { |file| require file }
end
