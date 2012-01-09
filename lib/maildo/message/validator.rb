module Maildo::Message

  class MalformedSubjectError < RuntimeError
  end

  class Validator

    VALID_SUBJECTS = [
      /^DONE \[(\w+)\]\s+(.+?)\s+$/,
      /^ADD \[(\w+)\]\s+(.+?)\s+$/,
      /^LIST \[(\w+)\]\s+$/,
      /^SUBSCRIBE \[(\w+)\]$/,
      /^UNSUBSCRIBE \[(\w+)\]$/
    ]

    def validate(subject)
      valid = false
      VALID_SUBJECTS.each do |re|

      end
      raise MalformedSubjectError
    end

  end

end
