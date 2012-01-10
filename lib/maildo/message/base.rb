module Maildo::Message
  class Base

    attr_reader :sender

    def initialize(sender)
      @sender = sender
    end

  end
end
