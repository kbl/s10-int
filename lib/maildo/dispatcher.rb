module Maildo
  class Dispatcher

    def initialize(handler = Message::Handler.new, 
                   mail_server = MailServer.new)
      @handler     = handler
      @mail_server = mail_server
    end

    def tick
      Config.logger.debug('tick')

      mails = @mail_server.retrieve_and_delete_all
      mails.each { |message| send_email(response(message)) }
    end

    private 

    def response(message)
      @handler.handle(message).execute                                                                                          
    end

    def send_email(response)
      Config.logger.debug("sending response: #{response}")
      response.mail.deliver!
    end

  end
end
