require 'maildo'

module Maildo::Message
  class Add < TasksAwareMessage
    
    attr_reader :body

    def initialize(sender, list_id, body)
      super(sender, list_id)
      @body = body
    end

    def execute
      super
      tasks.add(body)
    end

  end
end
