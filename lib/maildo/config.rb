require 'maildo'

module Maildo
  class Config

    attr_reader :sender, :store_path, :logdev

    def self.instance(&block)
      @instance ||= Config.new(&block)
    end

    def initialize(&block)
      set_default_values
      instance_eval &block if block_given?
    end

    private

    def set_default_values
      @logdev = STDOUT
      @store_path = ENV['MAILDO_STORE_PATH']
    end

  end
end
