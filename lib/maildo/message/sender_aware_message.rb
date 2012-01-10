module Maildo::Message
  class SenderAwareMessage

    attr_reader :sender

    def initialize(sender)
      @sender = sender
    end

  end
end
