module Maildo
  module Message
    module SubscribersAwareMessage

      attr_reader :list_id
      
      def initialize_message(sender, list_id)
        @list_id = list_id
        @subscribers = Maildo::List::Subscribers.new(list_id)

        super
      end

    end
  end
end
