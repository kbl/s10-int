module Maildo
  module Message
    class Response

      attr_reader :subject, :body, :to

      def initialize(to, subject, body = nil)
        @to, @subject, @body = to, subject, body
      end

      def mail
        @mail || prepare_mail
      end

      def to_s
        "to: #{to} subject: #{subject} body: #{body}"
      end

      private

      def prepare_mail
        m = Mail.new
        m.to = to
        m.subject = subject
        m.body = body
        m.from = Maildo::Config::SENDER

        @mail = m
      end

    end
  end
end
