require 'maildo'

module Maildo
  module Looper

    def self.start(dispatcher = Dispatcher.new)
      EM.run do
        start_timer(dispatcher)
      end
    end

    private

    def self.start_timer(dispatcher)
      timer = EventMachine::PeriodicTimer.new(Maildo::Config::PROBE_INTERVAL) do
        log.debug('tick')
        dispatcher.tick
      end
    end

    def self.log
      @log ||= Logger.new(STDOUT)
    end

  end
end

Maildo::Looper.start
