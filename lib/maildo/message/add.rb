module Maildo
  module Message
    class Add

      include SenderAwareMessage
      include SubscribersAwareMessage
      include TasksAwareMessage
      
      attr_reader :body

      def initialize(sender, list_id, body)
        @body = body
        initialize_sender(sender)
        initialize_subscribers(sender, list_id)
        initialize_tasks(sender, list_id)
      end

      def execute
        response = super
        return response if response

        @tasks.add(body)
        response('Task added', "Task #{body} successfully added to list #{list_id}.")
      end

    end
  end
end
