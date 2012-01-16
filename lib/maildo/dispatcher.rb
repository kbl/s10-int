module Maildo
  class Dispatcher

    def initialize(parser = Message::Parser.new, mail_server = MailServer.new)
      @parser, @mail_server = parser, mail_server
    end

    def tick
      Maildo.logger.debug('tick')

      mails = @mail_server.retrieve_and_delete_all
      responses = mails.map do |mail|
        dispatch(mail).execute
      end
      responses.each do |response|
        send_email(response)
      end
    end

    private 

    def dispatch(message)
      @parser.parse(message)
    end

    def send_email(response)
      Maildo.logger.debug("sending response: #{response}")
      response.mail.deliver!
    end

  end
end
