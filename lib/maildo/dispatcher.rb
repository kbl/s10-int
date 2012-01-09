module Maildo
  class Dispatcher

    attr_reader :parser

    def initialize(parser = Message::Parser.new)
      @parser = parser
    end

    def dispatch(message)
      parser.parse(message.subject)
    end

  end
end
