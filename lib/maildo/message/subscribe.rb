require 'maildo'

module Maildo::Message
  class Subscribe < SubscribersAwareMessage

    def initialize(sender, list_id)
      super(sender, list_id)
    end

    def execute
      if subscribers.subscribed?(sender)
        return Response.new('Illegal action', "You are already subscribed to list [#{list_id}].")
      end
      subscribers.subscribe(sender)
      Response.new('Subscribed successfully', "You are currently subscribed to list [#{list_id}].")
    end

  end
end
