module Maildo::Message
  class List < TasksAwareMessage
    
    def initialize(sender, list_id)
      super(sender, list_id)
    end

    def execute
      super
    end

  end
end
