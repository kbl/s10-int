module Maildo::Message
  class TasksAwareMessage < SubscribersAwareMessage
    
    def initialize(sender, list_id)
      super(sender, list_id)
      @tasks = Maildo::List::Tasks.new(list_id)
    end

    def execute
      unless subscribers.subscribed?(sender)
        return Response.new('Access denied', "You aren't allowed to send such message. Please subscribe to [#{list_id}]")
      end
    end

    private

    attr_reader :tasks

  end
end
