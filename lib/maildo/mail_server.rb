module Maildo
  class MailServer

    def initialize(provider = Mail)
      @provider = provider
    end

    def retrieve_and_delete_all
      messages = provider.all
      provider.delete_all
      messages.map do |msg|
        {subject: msg.subject, from: msg.from[0]}
      end
    end

    private

    attr_reader :provider

  end
end
