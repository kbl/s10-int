require 'maildo'

module Maildo::Message

  class MalformedSubjectError < RuntimeError
  end

  class Parser

    VALID_SUBJECTS = {
      /^DONE \[(\w+)\]\s+(.+?)\s*$/ => Maildo::Message::Done,
      /^ADD \[(\w+)\]\s+(.+?)\s*$/ => Maildo::Message::Add,
      /^LIST \[(\w+)\]\s+$/ => nil,
      /^SUBSCRIBE \[(\w+)\]$/ => Maildo::Message::Subscribe,
      /^UNSUBSCRIBE \[(\w+)\]$/ => nil
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
