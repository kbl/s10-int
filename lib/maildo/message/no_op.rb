module Maildo::Message
  class NoOp

    def initialize(subject)
      @subject = subject
    end

    def execute
      response
    end

    private

    attr_reader :subject

    def response
      return @response if @response
      @response = Response.new('Illegal message', "Message [#{subject}] could not be processed successfully.")
    end

  end
end
