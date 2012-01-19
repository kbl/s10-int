module Maildo
  module Message
    module TasksAwareMessage

      def execute
        unless @subscribers.subscribed?(sender)
          response('Access denied', "You aren't allowed to send such message. Please subscribe to [#{list_id}].")
        end
      end

      private

      def initialize_tasks(sender, list_id)
        @tasks = Maildo::List::Tasks.new(list_id)
      end

    end
  end
end
