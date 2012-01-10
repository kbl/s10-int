module Maildo::Message

  class NotYetSubscribedError < RuntimeError
  end

  class Unsubscribe < SubscribersAwareMessage

    def initialize(sender, list_id)
      super(sender, list_id)
    end

    def execute
      unless subscribers.subscribed?(sender)
        raise NotYetSubscribedError
      end
      subscribers.unsubscribe(sender)
    end

  end
end
