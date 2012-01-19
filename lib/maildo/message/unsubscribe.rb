module Maildo
  module Message
    class Unsubscribe

      include SenderAwareMessage
      include SubscribersAwareMessage

      def execute
        unless @subscribers.subscribed?(sender)
          return response('Access denied', "You aren't allowed to send such message. Please subscribe to [#{list_id}]")
        end
        @subscribers.unsubscribe(sender)
        response('Unsubscribed successfully', "You are now unsubscribed from list [#{list_id}].")
      end

    end
  end
end
