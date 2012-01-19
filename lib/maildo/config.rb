module Maildo

  class << self
    attr_accessor :logger
  end

  class Config

    DEFAULT_LOGGER = Logger.new(STDOUT)

    attr_reader :store_path

    def initialize(&block)
      instance_eval &block if block_given?
      set_default_values

      Maildo.logger = @logger
    end

    private

    def set_store_path(path)
      @store_path = path
    end

    def set_logger(logger)
      @logger = logger
    end

    def set_default_values
      @logger ||= DEFAULT_LOGGER
      @store_path ||= ENV['MAILDO_STORE_PATH']
    end

  end
end
