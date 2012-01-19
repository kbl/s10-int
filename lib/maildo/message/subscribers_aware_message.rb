module Maildo
  module Message
    module SubscribersAwareMessage

      attr_reader :list_id

      private
      
      def initialize_subscribers(sender, list_id)
        @list_id = list_id
        @subscribers = Maildo::List::Subscribers.new(list_id)
      end

    end
  end
end
