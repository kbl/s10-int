module Maildo
  class MailServer

    def initialize(provider = Mail)
      @provider = provider
    end

    def retrieve_and_delete_all
      messages = @provider.find_and_delete
      messages.map do |msg|
        { subject: msg.subject, from: msg.from[0] }
      end
    end

  end
end
