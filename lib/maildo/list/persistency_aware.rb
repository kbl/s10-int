module Maildo
  module List
    module PersistencyAware

      private

      def store
        @store ||= Store.new(@list_id)
      end

    end
  end
end
