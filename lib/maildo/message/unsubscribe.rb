module Maildo::Message
  class Unsubscribe < SubscribersAwareMessage

    def initialize(sender, list_id)
      super(sender, list_id)
    end

    def execute
      unless subscribers.subscribed?(sender)
        return Response.new('Access denied', "You aren't allowed to send such message. Please subscribe to [#{list_id}]")
      end
      subscribers.unsubscribe(sender)
      Response.new('Unsubscribed successfully', "You are now unsubscribed from list [#{list_id}].")
    end

  end
end
