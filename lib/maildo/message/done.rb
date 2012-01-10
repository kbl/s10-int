module Maildo::Message
  class Done < Base
    
    attr_reader :list_id, :task_id

    def initialize(sender, list_id, task_id)
      super(sender)
      @list_id = list_id
      @task_id = task_id
    end
  end
end
