module Maildo
  class MailServer

    def initialize(provider = Mail)
      @provider = provider
      initialize_email
    end

    def retrieve_and_delete_all
      messages = @provider.find_and_delete
      emails = messages.map do |msg|
        { subject: msg.subject, from: msg.from[0] }
      end
      Maildo::Logger.debug("emails: #{emails.length}")

      emails
    end

    private

    def initialize_email
      Mail.defaults do
        retriever_method :imap,
                       { address: 'imap.gmail.com',
                         port: 993,
                         user_name: ENV['MAILDO_MAIL'],
                         password: ENV['MAILDO_PASS'],
                         enable_ssl: true }
        delivery_method :smtp,
                      { address: 'smtp.gmail.com',
                        port: 587,
                        domain: 'rmu-maildo.com',
                        user_name: ENV['MAILDO_MAIL'],
                        password: ENV['MAILDO_PASS'],
                        authentication: 'plain',
                        enable_starttls_auto: true }
      end
    end

  end
end
