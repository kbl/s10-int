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

    def parse(subject)
      VALID_SUBJECTS.each do |re, klass|
        match = re.match(subject)
        if match
          return klass.new(*match.captures())
        end
      end
      raise MalformedSubjectError
    end

  end

end
