require 'maildo'

module Maildo::Message

  class AlreadySubscribedError < RuntimeError
  end

  class Subscribe < Base

    attr_reader :list_id

    def initialize(sender, list_id)
      super(sender)
      @list_id = list_id
      @subscription_list = Maildo::List::Subscribers.new(list_id)
    end

    def execute
      if subscription_list.subscribed?(sender)
        raise AlreadySubscribedError
      end
      subscription_list.subscribe(sender)
    end

    private

    attr_reader :subscription_list

  end
end
