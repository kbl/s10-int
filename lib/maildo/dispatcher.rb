module Maildo
  class Dispatcher

    def initialize(
        mail_server = MailServer.new, 
        parser = Message::Parser.new,
        logger = Logger.new(STDOUT))
      @parser = parser
      @mail_server = mail_server
      @logger = logger
    end

    def tick
      mails = @mail_server.retrieve_and_delete_all
      @logger.debug("mails: #{mails.length}")
      responses = mails.map do |mail|
        @logger.debug("get mail: #{mail}")
        dispatch(mail).execute
      end
      responses.each do |response|
        @logger.debug("sending response: #{response}")
        response.mail.deliver!
      end
    end

    private 

    def dispatch(message)
      @parser.parse(message)
    end

  end
end
