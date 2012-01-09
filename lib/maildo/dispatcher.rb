module Maildo
  class Dispatcher

    attr_reader :validator

    def initialize(validator = Message::Validator.new)
      @validator = validator
    end

    def dispatch(message)
      validator.validate(message.subject)
    end

  end
end
