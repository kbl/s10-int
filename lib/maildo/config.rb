module Maildo

  Config = Object.new

  class << Config

    DEFAULT_LOGGER = Logger.new(STDOUT)
    DEFAULT_STORE_PATH = ENV['MAILDO_STORE_PATH']

    attr_writer :logger, :store_path

    def logger
      @logger ||= DEFAULT_LOGGER
    end

    def store_path
      @store_path ||= DEFAULT_STORE_PATH
    end

  end
end
