module Maildo::List
  class Subscribers

    include Maildo::List::FileContent

    SUBSCRIBERS_FILE_SUFFIX = '-subscribers'

    def initialize(list_id)
      @list_id = list_id
      @path = subscribers_file_path(list_id)
    end

    def subscribe(subscriber)
      File.open(path, 'a') do |f|
        f.puts(subscriber)
      end
    end

    def unsubscribe(subscriber)
      s = subscribers
      s.delete(subscriber)
      replace_content(path, s)
    end

    def subscribed?(subscriber)
      subscribers.include?(subscriber)
    end

    def subscribers
      content(path)
    end

    private

    attr_reader :list_id, :path

    def subscribers_file_path(list_id)
      File.join(
        Maildo::Config::TODO_LISTS_PATH, 
        subscribers_file(list_id))
    end

    def subscribers_file(list_id)
      list_id + SUBSCRIBERS_FILE_SUFFIX
    end

  end
end
