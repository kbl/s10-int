require 'maildo'

module Maildo::Message

  class AlreadySubscribedError < RuntimeError
  end

  class Subscribe < SubscribersAwareMessage

    def initialize(sender, list_id)
      super(sender, list_id)
    end

    def execute
      if subscribers.subscribed?(sender)
        raise AlreadySubscribedError
      end
      subscribers.subscribe(sender)
    end

  end
end
