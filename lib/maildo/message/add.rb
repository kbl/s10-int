require 'maildo'

module Maildo::Message
  class Add < Base
    
    attr_reader :list_id, :body

    def initialize(sender, list_id, body)
      super(sender)
      @list_id = list_id
      @body = body
      @tasks = Maildo::List::Tasks.new(list_id)
      @subscribers = Maildo::List::Subscribers.new(list_id)
    end

    def execute
      unless subscribers.subscribed?(sender)
        raise NotYetSubscribedError
      end
      tasks.add(body)
    end

    private

    attr_reader :tasks, :subscribers

  end
end
