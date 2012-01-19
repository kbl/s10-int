module Maildo
  module List
    module PersistencyAware

      def initialize(list_id)
        @list_id = list_id
      end

      private

      def store
        @store ||= Store.new(@list_id)
      end
    end
  end
end
