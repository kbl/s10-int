module Maildo::Message
  class Response

    attr_reader :subject, :body

    def initialize(subject, body = nil)
      @subject, @body = subject, body
    end

  end
end
