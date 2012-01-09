module Maildo::Message
  class Done
    
    attr_reader :list_id, :task_id

    def initialize(list_id, task_id)
      @list_id = list_id
      @task_id = task_id
    end
  end
end
