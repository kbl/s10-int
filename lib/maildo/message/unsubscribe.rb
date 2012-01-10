module Maildo::Message

  class NotYetSubscribedError < RuntimeError
  end

  class Unsubscribe < SubscribersAwareMessage

    def initialize(sender, list_id)
      super(sender, list_id)
    end

    def execute
      raise NotYetSubscribedError unless subscribers.subscribed?(sender)
      subscribers.unsubscribe(sender)
    end

  end
end
