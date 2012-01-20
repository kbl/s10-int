module Maildo
  module Message
    class Parser

      def initialize
        @patterns = Hash.new { |hash, key| hash[key] = Set.new }
        @handlers = {}

        initialize_default_handlers
      end

      def define_pattern(name, pattern)
        @patterns[name] << pattern
      end

      def register_handler(name, &block)
        @handlers[name] = block
      end

      def parse(message)
        Config.logger.debug("parsing email: #{message}")

        subject = message[:subject]
        from = message[:from]

        @patterns.each do |handler_name, patterns|
          patterns.each do |re|
            match = re.match(subject)
            if match
              sender_with_additional_params = [from] + match.captures()
              return @handlers[handler_name].call(*sender_with_additional_params)
            end
          end
        end

        return Maildo::Message::NoOp.new(from, subject)
      end

      private

      def initialize_default_handlers
        define_pattern(:done, /^DONE \[(\w+)\]\s+(.+?)\s*$/)
        register_handler(:done) do |sender, list_id, task_id |
          Maildo::Message::Done.new(sender, list_id, task_id)
        end

        define_pattern(:add, /^ADD \[(\w+)\]\s+(.+?)\s*$/)
        register_handler(:add) do |sender, list_id, task|
          Maildo::Message::Add.new(sender, list_id, task)
        end

        define_pattern(:list, /^LIST \[(\w+)\]\s*$/)
        register_handler(:list) do |sender, list_id|
          Maildo::Message::List.new(sender, list_id)
        end

        define_pattern(:subscribe, /^SUBSCRIBE \[(\w+)\]\s*$/)
        register_handler(:subscribe) do |sender, list_id|
          Maildo::Message::Subscribe.new(sender, list_id)
        end

        define_pattern(:unsubscribe, /^UNSUBSCRIBE \[(\w+)\]\s*$/)
        register_handler(:unsubscribe) do |sender, list_id|
          Maildo::Message::Unsubscribe.new(sender, list_id)
        end
      end

    end
  end
end
