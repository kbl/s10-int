module Maildo
  class Dispatcher

    def initialize(mail_server = MailServer.new, parser = Message::Parser.new)
      @parser = parser
      @mail_server = mail_server
      @log = Logger.new(STDOUT)
    end

    def tick
      mails = mail_server.retrieve_and_delete_all
      log.debug("mails: #{mails.length}")
      responses = mails.map do |mail|
        log.debug("get mail: #{mail}")
        dispatch(mail).execute
      end
      responses.each do |response|
        log.debug("sending response: #{response}")
        response.mail.deliver!
      end
    end

    private 

    attr_reader :parser, :mail_server, :log

    def dispatch(message)
      parser.parse(message)
    end

  end
end
