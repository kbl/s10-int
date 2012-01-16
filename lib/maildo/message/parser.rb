require 'maildo'

module Maildo
  module Message
    class Parser

      VALID_SUBJECTS = {
        /^DONE \[(\w+)\]\s+(.+?)\s*$/ => Maildo::Message::Done,
        /^ADD \[(\w+)\]\s+(.+?)\s*$/ => Maildo::Message::Add,
        /^LIST \[(\w+)\]\s*$/ => Maildo::Message::List,
        /^SUBSCRIBE \[(\w+)\]\s*$/ => Maildo::Message::Subscribe,
        /^UNSUBSCRIBE \[(\w+)\]\s*$/ => Maildo::Message::Unsubscribe
      }

      def initialize(config)
        @config = config
      end

      def parse(message)
        Maildo.logger.debug("parsing email: #{message}")

        subject = message[:subject]
        from = message[:from]

        VALID_SUBJECTS.each do |re, klass|
          match = re.match(subject)
          if match
            config_sender_with_additional_params = [@config, from] + match.captures()
            return klass.new(*config_sender_with_additional_params)
          end
        end
        return Maildo::Message::NoOp.new(@config, from, subject)
      end

    end
  end
end
