module Maildo
  module List
    class Store

      def initialize(list_id)
        @path = File.join(Config.store_path, list_id)
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

      private

      def store
        @store ||= PStore.new(@path)
      end

    end
  end
end
