module Maildo::Message
  class SenderAwareMessage

    attr_reader :sender

    def initialize(sender)
      @sender = sender
    end

    private

    def response(subject, body)
      Response.new(sender, subject, body)
    end

  end
end
