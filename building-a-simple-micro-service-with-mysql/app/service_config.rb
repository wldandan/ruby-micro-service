require 'pathname'
require 'yaml'
require 'erb'

class ServiceConfig
  def self.root_path
    @root_path ||= Pathname.new(File.join(__dir__, '..')).realpath
  end

  def self.config
    @config ||= YAML.load(ERB.new(File.read(root_path.join('config', 'config.yml'))).result)
  end

  config.each do |name, value|
    define_singleton_method(name) { value }
  end
end
