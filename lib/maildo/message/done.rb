module Maildo::Message
  class Done < TasksAwareMessage
    
    attr_reader :task_id

    def initialize(sender, list_id, task_id)
      super(sender, list_id)
      @task_id = task_id
    end

    def execute
      super
    end

  end
end
