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

      def parse(message)
        subject = message[:subject]
        from = message[:from]

        VALID_SUBJECTS.each do |re, klass|
          match = re.match(subject)
          if match
            sender_with_additional_params = [from] + match.captures()
            return klass.new(*sender_with_additional_params)
          end
        end
        return Maildo::Message::NoOp.new(from, subject)
      end

    end
  end
end
