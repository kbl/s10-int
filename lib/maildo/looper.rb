require 'maildo'

module Maildo
  class Looper

    def initialize(dispatcher = Dispatcher.new)
      @dispatcher = dispatcher
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

    attr_reader :dispatcher
    
    def log
      @log || @log = Logger.new(STDOUT)
    end

  end
end

Maildo::Looper.new.loop
