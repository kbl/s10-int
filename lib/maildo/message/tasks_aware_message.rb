module Maildo
  module Message
    module TasksAwareMessage
      
      def initialize(sender, list_id)
        super
        @tasks = Maildo::List::Tasks.new(list_id)
      end

      def execute
        unless @subscribers.subscribed?(sender)
          response('Access denied', "You aren't allowed to send such message. Please subscribe to [#{list_id}].")
        end
      end

    end
  end
end
