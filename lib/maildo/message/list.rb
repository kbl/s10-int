module Maildo::Message
  class List < TasksAwareMessage
    
    def initialize(sender, list_id)
      super(sender, list_id)
    end

    def execute
      response = super
      return response if response

      t = tasks.tasks
      Response.new("Todo list #{list_id}", response_body(t))
    end

    private

    def response_body(tasks)
      body = "List contains following tasks:\n\n"
      body + tasks.map.each_with_index { |t, i| "#{i + 1}. #{t}" }.join("\n") + "\n"
    end

  end
end
