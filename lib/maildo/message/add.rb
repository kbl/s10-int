require 'maildo'

module Maildo::Message
  class Add < TasksAwareMessage
    
    attr_reader :body

    def initialize(sender, list_id, body)
      super(sender, list_id)
      @body = body
    end

    def execute
      response = super
      return response if response

      tasks.add(body)
      return Response.new('Task added', "Task #{body} successfully added to list #{list_id}.")
    end

  end
end
