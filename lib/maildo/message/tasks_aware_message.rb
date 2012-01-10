module Maildo::Message
  class TasksAwareMessage < SubscribersAwareMessage
    
    def initialize(sender, list_id)
      super(sender, list_id)
      @tasks = Maildo::List::Tasks.new(list_id)
    end

    def execute
      unless subscribers.subscribed?(sender)
        raise NotYetSubscribedError
      end
    end

    private

    attr_reader :tasks

  end
end
