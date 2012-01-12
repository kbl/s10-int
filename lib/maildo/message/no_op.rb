module Maildo
  module Message
    class NoOp

      def initialize(sender, subject)
        @sender, @subject = sender, subject
      end

      def execute
        response
      end

      private

      attr_reader :subject, :sender

      def response
        @response || @response = Response.new(
            sender, 
            'Illegal message', "Message [#{subject}] could not be processed successfully.")
      end

    end
  end
end
