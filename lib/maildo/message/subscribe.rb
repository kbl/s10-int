require 'maildo'

module Maildo::Message

  class AlreadySubscribedError < RuntimeError
  end

  class Subscribe < Base

    attr_reader :list_id

    def initialize(sender, list_id)
      super(sender)
      @list_id = list_id
    end

    def execute
      if subscribers(list_id).include?(sender)
        raise AlreadySubscribedError
      end
      subscribe(list_id, sender)
    end

    private

    include Maildo::List::SubscriptionManager

  end
end
