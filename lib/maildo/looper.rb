require 'maildo'

module Maildo
  module Looper

    CHECK_INTERVAL = 10

    def self.start(dispatcher = Dispatcher.new)
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

Maildo::Looper.start
