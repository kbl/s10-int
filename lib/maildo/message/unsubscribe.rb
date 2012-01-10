module Maildo::Message

  class NotYetSubscribedError < RuntimeError
  end

  class Unsubscribe < SenderAwareMessage

    attr_reader :list_id

    def initialize(sender, list_id)
      super(sender)
      @list_id = list_id
      @subscription_list = Maildo::List::Subscribers.new(list_id)
    end

    def execute
      unless subscription_list.subscribed?(sender)
        raise NotYetSubscribedError
      end
      subscription_list.unsubscribe(sender)
    end

    private

    attr_reader :subscription_list

  end
end
