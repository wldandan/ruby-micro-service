require 'logger'
require 'pathname'

module Logging
  def logger
    Logging.logger
  end

  LOG_FILE = ENV['RACK_ENV'] == 'production' ? STDOUT : "log/#{ENV['RACK_ENV']}.log"

  class << self
    def logger
      @logger ||= begin
        logger = Logger.new(LOG_FILE)
        logger.level = Logger::DEBUG
        logger
      end
    end

    def test_env?
      ENV['APP_ENV'] == 'TEST'
    end
  end
end
