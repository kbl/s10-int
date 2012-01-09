module Maildo::Message

  class MalformedSubjectError < RuntimeError
  end

  class Parser

    VALID_SUBJECTS = [
      /^DONE \[(\w+)\]\s+(.+?)\s+$/,
      /^ADD \[(\w+)\]\s+(.+?)\s+$/,
      /^LIST \[(\w+)\]\s+$/,
      /^SUBSCRIBE \[(\w+)\]$/,
      /^UNSUBSCRIBE \[(\w+)\]$/
    ]

    def parse(subject)
      valid = false
      VALID_SUBJECTS.each do |re|
        if re.match(subject)
          return Subscription.new($1)
        end
      end
      raise MalformedSubjectError
    end

  end

end
