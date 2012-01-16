require 'maildo'

module Maildo
  module Message
    class Subscribe

      include SenderAwareMessage
      include SubscribersAwareMessage

      def initialize(config, sender, list_id)
        super
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
