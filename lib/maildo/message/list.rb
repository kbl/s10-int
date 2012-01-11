module Maildo::Message
  class List < TasksAwareMessage
    
    def initialize(sender, list_id)
      super(sender, list_id)
    end

    def execute
      response = super
      return response if response

      tasks.tasks
    end

  end
end
