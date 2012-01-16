module Maildo
  module Message
    module SubscribersAwareMessage

      attr_reader :list_id
      
      def initialize(config, sender, list_id)
        super(sender)
        @list_id = list_id
        @subscribers = Maildo::List::Subscribers.new(config.store_path, list_id)
      end

    end
  end
end
