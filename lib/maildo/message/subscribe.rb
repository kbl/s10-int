require 'maildo'

module Maildo
  module Message
    class Subscribe < SubscribersAwareMessage

      def initialize(sender, list_id)
        super(sender, list_id)
      end

      def execute
        if @subscribers.subscribed?(sender)
          return response('Illegal action', "You are already subscribed to list [#{list_id}].")
        end
        @subscribers.subscribe(sender)
        response('Subscribed successfully', "You are currently subscribed to list [#{list_id}].")
      end

    end
  end
end
