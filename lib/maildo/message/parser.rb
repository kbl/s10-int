require 'maildo'

module Maildo::Message

  class MalformedSubjectError < RuntimeError
  end

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
      VALID_SUBJECTS.each do |re, klass|
        match = re.match(message.subject)
        if match
          sender_with_additional_params = [message.from[FIRST_SENDER]] + match.captures()
          return klass.new(*sender_with_additional_params)
        end
      end
      raise MalformedSubjectError
    end

  end

end
