require 'maildo'

module Maildo

  class << self
    attr_accessor :logger
  end

  class Config

    attr_reader :store_path, :logdev

    def initialize(&block)
      set_default_values
      instance_eval &block if block_given?

      @logger = Logger.new(@logdev)
      Maildo.logger = @logger
    end

    private

    def set_default_values
      @logdev = STDOUT
      @store_path = ENV['MAILDO_STORE_PATH']
    end

  end
end
