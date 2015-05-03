require 'logger'
require 'pathname'

module Logging
  def logger
    Logging.logger
  end

  class << self
    def logger
      @logger ||= begin
        logger = test_env? ? Logger.new('/dev/null') : Logger.new(STDOUT)
        logger.level = Logger::DEBUG
        logger
      end
    end

    def test_env?
      ENV['APP_ENV'] == 'TEST'
    end
  end
end
