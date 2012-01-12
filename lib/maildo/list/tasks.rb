module Maildo
  module List

    class IllegalTaskIdentifierError < RuntimeError
    end

    class Tasks

      ONLY_NUMBERS = /^\d+$/

      def initialize(list_id)
        @list_id = list_id
        @path = Tasks.path(list_id)
        @store = PStore.new(path)
      end

      def add(task)
        store.transaction do
          store[:tasks] ||= []
          store[:tasks] << task
        end
      end

      def done(one_based_task_index)
        raise IllegalTaskIdentifierError unless one_based_task_index =~ ONLY_NUMBERS

        t = tasks
        index = one_based_task_index.to_i - 1
        index_invalid = index < 0 || index >= t.length

        raise IllegalTaskIdentifierError if index_invalid

        task = t.delete_at(index)
        store.transaction do
          store[:tasks] = t
        end
        task
      end

      def tasks
        content = store.transaction do
          store[:tasks] || []
        end
        content
      end

      def self.path(list_id)
        File.join(
          Maildo::Config::TODO_LISTS_PATH,
          list_id)
      end

      private

      attr_reader :list_id, :path, :store

    end
  end
end
