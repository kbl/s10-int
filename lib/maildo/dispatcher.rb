module Maildo
  class Dispatcher

    def initialize(parser = Message::Parser.new, mail_server = MailServer.new)
      @parser = parser
      @mail_server = mail_server
    end

    def tick
      Maildo.logger.debug('tick')

      mails = @mail_server.retrieve_and_delete_all
      mails
        .map { |mail| dispatch(mail).execute }
        .each { |response| send_email(response) }
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
