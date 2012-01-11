module Maildo
  module List

    class IllegalTaskIdentifierError < RuntimeError
    end

    class Tasks

      include Maildo::List::FileContent

      ONLY_NUMBERS = /^\d+$/

      def initialize(list_id)
        @list_id = list_id
        @path = Tasks.path(list_id)
      end

      def add(task)
        File.open(path, 'a') do |f|
          f.puts(task)
        end
      end

      def done(one_based_task_index)
        raise IllegalTaskIdentifierError unless one_based_task_index =~ ONLY_NUMBERS

        t = tasks
        index = one_based_task_index.to_i - 1
        index_invalid = index < 0 || index >= t.length

        raise IllegalTaskIdentifierError if index_invalid

        task = t.delete_at(index)
        replace_content(path, t)
        task
      end

      def tasks
        content(path)
      end

      def self.path(list_id)
        File.join(
          Maildo::Config::TODO_LISTS_PATH,
          list_id)
      end

      private

      attr_reader :list_id, :path

    end
  end
end
