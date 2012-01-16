module Maildo
  class Dispatcher

    attr_writer :config

    def initialize(mail_server = MailServer.new, 
                   parser = Message::Parser.new, 
                   config = Config.new)
      @parser = parser
      @mail_server = mail_server
      @config = config
    end

    def tick
      Logger.debug('tick')

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
      Logger.debug("sending response: #{response}")
      response.mail.deliver!
    end

  end
end
