module Maildo
  module List
    module PersistencyAware

      def initialize(store_path, list_id)
        @store_path, @list_id = store_path, list_id
      end

      private

      def store
        @store ||= Store.new(@store_path, @list_id)
      end
    end
  end
end
