module Maildo
  module List
    class Subscribers

      SUBSCRIBERS_FILE_SUFFIX = '-subscribers'

      def initialize(list_id)
        @list_id = list_id
      end

      def subscribe(subscriber)
        store.add(:subscribers, subscriber)
      end

      def unsubscribe(subscriber)
        s = subscribers
        s.delete(subscriber)

        if s.length == 0
          delete_unnecessary_files
        else
          store[:subscribers] = s
        end
      end

      def subscribed?(subscriber)
        subscribers.include?(subscriber)
      end

      def subscribers
        store[:subscribers]
      end

      private

      attr_reader :list_id

      def store
        @store ||= Store.new(list_id)
      end

      def delete_unnecessary_files
        store.delete!
      end

    end
  end
end
