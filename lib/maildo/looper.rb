require 'maildo'

module Maildo
  module Looper

    CHECK_INTERVAL = 20

    def self.start(dispatcher = Dispatcher.new, &config_block)
      if block_given?
        config = Maildo::Config.new(&config_block)
        dispathcer.config = config
      end

      EM.run do
        start_timer(dispatcher)
      end
    end

    private

    def self.start_timer(dispatcher)
      timer = EventMachine::PeriodicTimer.new(CHECK_INTERVAL) do
        dispatcher.tick
      end
    end

  end
end
