require 'maildo'

module Maildo::Message

  class Parser

    VALID_SUBJECTS = {
      /^DONE \[(\w+)\]\s+(.+?)\s*$/ => Maildo::Message::Done,
      /^ADD \[(\w+)\]\s+(.+?)\s*$/ => Maildo::Message::Add,
      /^LIST \[(\w+)\]\s*$/ => Maildo::Message::List,
      /^SUBSCRIBE \[(\w+)\]\s*$/ => Maildo::Message::Subscribe,
      /^UNSUBSCRIBE \[(\w+)\]\s*$/ => Maildo::Message::Unsubscribe
    }

    FIRST_SENDER = 0

    def parse(message)
      subject = message.subject
      VALID_SUBJECTS.each do |re, klass|
        match = re.match(subject)
        if match
          sender_with_additional_params = [message.from[FIRST_SENDER]] + match.captures()
          return klass.new(*sender_with_additional_params)
        end
      end
      return Maildo::Message::NoOp.new(subject)
    end

  end

end
