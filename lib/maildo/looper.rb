require 'maildo'

module Maildo
  class Looper

    def initialize(dispatcher = Dispatcher.new)
      @dispatcher = dispatcher
      @log = Logger.new(STDOUT)
    end

    def loop
      while true
        log.debug('tick')
        dispatcher.tick
        log.debug('sleep')
        sleep(Maildo::Config::PROBE_INTERVAL)
        log.debug('wake up!')
      end
    end

    private

    attr_reader :dispatcher, :log

  end
end

Maildo::Looper.new.loop
