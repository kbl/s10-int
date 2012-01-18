module Maildo

  class << self
    attr_accessor :logger
  end

  class Config

    attr_reader :store_path

    def initialize(&block)
      set_default_values
      instance_eval &block if block_given?

      Maildo.logger = @logger
    end

    private

    def set_default_values
      @logger = Logger.new(STDOUT)
      @store_path = ENV['MAILDO_STORE_PATH']
    end

  end
end
