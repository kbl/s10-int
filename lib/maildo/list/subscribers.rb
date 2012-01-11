module Maildo
  module List
    class Subscribers

      include Maildo::List::FileContent

      SUBSCRIBERS_FILE_SUFFIX = '-subscribers'

      def initialize(list_id)
        @list_id = list_id
        @path = Subscribers.path(list_id)
      end

      def subscribe(subscriber)
        File.open(path, 'a') do |f|
          f.puts(subscriber)
        end
      end

      def unsubscribe(subscriber)
        s = subscribers
        s.delete(subscriber)

        if s.length == 0
          delete_unnecessary_files
        else
          replace_content(path, s)
        end
      end

      def subscribed?(subscriber)
        subscribers.include?(subscriber)
      end

      def subscribers
        content(path)
      end

      def self.path(list_id)
        subscribers_file = list_id + SUBSCRIBERS_FILE_SUFFIX
        File.join(
          Maildo::Config::TODO_LISTS_PATH, 
          subscribers_file)
      end

      private

      attr_reader :list_id, :path

      def delete_unnecessary_files
        File.delete(path)

        tasks_path = Tasks.path(list_id)
        File.delete(tasks_path) if File.exists?(tasks_path)
      end

    end
  end
end
