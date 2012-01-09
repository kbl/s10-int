module Maildo::Message
  class Add
    
    attr_reader :list_id, :body

    def initialize(list_id, body)
      @list_id = list_id
      @body = body
    end
  end
end
