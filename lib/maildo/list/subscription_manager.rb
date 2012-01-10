module Maildo::List
  module SubscriptionManager

    def subscribers(list_id)
      subscribers = []
      list_path = subscribers_file_path(list_id)

      if File.exists?(list_path)
        File.open(list_path) do |f|
          f.each { |subscriber| subscribers << subscriber.chomp() }
        end
      end
      subscribers
    end

    def subscribe(list_id, subscriber)
      list_path = subscribers_file_path(list_id)

      File.open(list_path, 'a') do |f|
        f.puts(subscriber)
      end
    end

    private

    SUBSCRIBERS_FILE_SUFFIX = '-subscribers'

    def subscribers_file_path(list_id)
      File.join(Maildo::Config::TODO_LISTS_PATH, subscribers_file(list_id))
    end

    def subscribers_file(list_id)
      list_id + SUBSCRIBERS_FILE_SUFFIX
    end

  end
end
