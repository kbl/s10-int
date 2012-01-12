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

      def set(key, value)
        store.transaction do
          store[key] = value
        end
      end

      def get(key)
        store.transaction do
          store[key] || []
        end
      end

      def self.path(list_id)
        File.join(
          Maildo::Config::TODO_LISTS_PATH,
          list_id)
      end

      private

      attr_reader :path

      def store
        @store || @store = PStore.new(path)
      end

    end
  end
end
