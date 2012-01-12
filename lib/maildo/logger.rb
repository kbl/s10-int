module Maildo
  module Logger

    def self.debug(message)
      logger.debug(message)
    end

    private

    def self.logger
      @logger ||= ::Logger.new(Maildo::Config.instance.logdev)
    end

  end
end
