module Maildo
  module List
    class Store

      def initialize(list_id)
        @path = Store.path(list_id)
      end

      def add(key, value)
        store.transaction do
          store[key] ||= []
          store[key] << value
        end
      end

      def []=(key, value)
        store.transaction do
          store[key] = value
        end
      end

      def [](key)
        store.transaction do
          store[key] || []
        end
      end

      def delete!
        File.delete(@path)
      end

      def self.path(list_id)
        File.join(
          Maildo::Config::TODO_LISTS_PATH,
          list_id)
      end

      private

      def store
        @store ||= PStore.new(@path)
      end

    end
  end
end
