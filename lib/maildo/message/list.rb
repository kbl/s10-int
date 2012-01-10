module Maildo::Message
  class List < SenderAwareMessage
    
    attr_reader :list_id

    def initialize(sender, list_id)
      super(sender)
      @list_id = list_id
    end

    def execute
    end
  end
end
