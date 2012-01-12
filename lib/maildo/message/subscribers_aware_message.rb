module Maildo
  module Message
    class SubscribersAwareMessage < SenderAwareMessage

      attr_reader :list_id
      
      def initialize(sender, list_id)
        super(sender)
        @list_id = list_id
        @subscribers = Maildo::List::Subscribers.new(list_id)
      end

    end
  end
end
