module Maildo
  module Looper

    def self.start(dispatcher = Dispatcher.new)
      EM.run do
        start_timer(dispatcher)
      end
    end

    private

    def self.start_timer(dispatcher)
      EventMachine::PeriodicTimer.new(Config.check_interval) do
        dispatcher.tick
      end
    end

  end
end
