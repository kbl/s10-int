module Maildo
  class Dispatcher

    def initialize(mail_server = MailServer.new, parser = Message::Parser.new)
      @parser = parser
      @mail_server = mail_server
    end

    def tick
      mails = mail_server.retrieve_and_delete_all
    end

    private 

    attr_reader :parser, :mail_server

    def dispatch(message)
      parser.parse(message)
    end

  end
end
