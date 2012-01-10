module Maildo::Message
  class Add < Base
    
    attr_reader :list_id, :body

    def initialize(sender, list_id, body)
      super(sender)
      @list_id = list_id
      @body = body
    end
  end
end
