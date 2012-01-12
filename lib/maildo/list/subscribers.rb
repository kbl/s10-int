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
          store.set(:subscribers, s)
        end
      end

      def subscribed?(subscriber)
        subscribers.include?(subscriber)
      end

      def subscribers
        store.get(:subscribers)
      end

      private

      attr_reader :list_id

      def store
        @store || @store = Store.new(list_id)
      end

      def delete_unnecessary_files
        File.delete(Store.path(list_id))
      end

    end
  end
end
