module Maildo::Message
  class List
    
    attr_reader :list_id

    def initialize(list_id)
      @list_id = list_id
    end
  end
end
