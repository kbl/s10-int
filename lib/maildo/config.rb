module Maildo

  Config = Object.new

  class << Config

    DEFAULT_LOGGER         = Logger.new(STDOUT)
    DEFAULT_STORE_PATH     = ENV['MAILDO_STORE_PATH']
    DEFAULT_CHECK_INTERVAL = 2

    attr_writer :logger, :store_path, :check_interval

    def logger
      @logger ||= DEFAULT_LOGGER
    end

    def store_path
      @store_path ||= DEFAULT_STORE_PATH
    end
    
    def check_interval
      @check_interval ||= DEFAULT_CHECK_INTERVAL
    end

  end
end
