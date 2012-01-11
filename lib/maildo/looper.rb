require 'maildo'

module Maildo
  class Looper

    def initialize(dispatcher = Dispatcher.new)
      @dispatcher = dispatcher
    end

    def loop
      while true
        dispatcher.tick
        sleep(Maildo::Config::PROBE_INTERVAL)
      end
    end

    private

    attr_reader :dispatcher

  end
end

Maildo::Looper.new.loop
