module Maildo
  module List

    IllegalTaskIdentifierError = Class.new(RuntimeError)

    class Tasks

      ONLY_NUMBERS = /^\d+$/

      def initialize(list_id)
        @list_id = list_id
      end

      def add(task)
        store.add(:tasks, task)
      end

      def done(one_based_task_index)
        raise IllegalTaskIdentifierError unless one_based_task_index =~ ONLY_NUMBERS

        t = tasks
        index = one_based_task_index.to_i - 1
        index_invalid = index < 0 || index >= t.length

        raise IllegalTaskIdentifierError if index_invalid

        task = t.delete_at(index)
        store[:tasks] = t

        task
      end

      def tasks
        store[:tasks]
      end

      private

      attr_reader :list_id

      def store
        @store || @store = Store.new(list_id)
      end

    end
  end
end
