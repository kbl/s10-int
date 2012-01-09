require 'maildo'

module Maildo::Message

  class MalformedSubjectError < RuntimeError
  end

  class Parser

    VALID_SUBJECTS = {
      /^DONE \[(\w+)\]\s+(.+?)\s+$/ => nil,
      /^ADD \[(\w+)\]\s+(.+?)\s+$/ => nil,
      /^LIST \[(\w+)\]\s+$/ => nil,
      /^SUBSCRIBE \[(\w+)\]$/ => Maildo::Message::Subscription,                                                                        
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
