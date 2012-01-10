module Maildo::List
  class Tasks

    include Maildo::List::FileContent

    def initialize(list_id)
      @list_id = list_id
      @path = tasks_file_path(list_id)
    end

    def add(task)
      File.open(path, 'a') do |f|
        f.puts(task)
      end
    end

    def tasks
      content(path)
    end

    private

    attr_reader :list_id, :path

    def tasks_file_path(list_id)
      File.join(
        Maildo::Config::TODO_LISTS_PATH,
        list_id)
    end

  end
end
