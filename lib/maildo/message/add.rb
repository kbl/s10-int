require 'maildo'

module Maildo
  module Message
    class Add

      include SenderAwareMessage
      include SubscribersAwareMessage
      include TasksAwareMessage
      
      attr_reader :body

      def initialize(sender, list_id, body)
        super(sender, list_id)
        @body = body
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
