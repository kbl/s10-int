module Maildo::Message
  class List < Base
    
    attr_reader :list_id

    def initialize(sender, list_id)
      super(sender)
      @list_id = list_id
    end
  end
end
