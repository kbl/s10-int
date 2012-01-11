module Maildo::Message
  class Response

    attr_reader :subject, :body, :to

    def initialize(to, subject, body = nil)
      @to, @subject, @body = to, subject, body
    end

    def mail
      m = Mail.new
      m.to = to
      m.subject = subject
      m.body = body
      m.from = Maildo::Config::SENDER

      m
    end

  end
end
