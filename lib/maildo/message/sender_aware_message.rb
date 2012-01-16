module Maildo
  module Message
    module SenderAwareMessage

      attr_reader :sender

      def initialize(sender)
        super
        @sender = sender
      end

      private

      def response(subject, body)
        Response.new(sender, subject, body)
      end

    end
  end
end
