module Maildo
  module Message
    module SenderAwareMessage

      attr_reader :sender

      private

      def initialize_sender(sender)
        @sender = sender
      end

      def response(subject, body)
        Response.new(sender, subject, body)
      end

    end
  end
end
