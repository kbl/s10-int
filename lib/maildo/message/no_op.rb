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

      def response
        @response ||= Response.new(
            @sender, 
            'Illegal message', "Message [#{@subject}] could not be processed successfully.")
      end

    end
  end
end
