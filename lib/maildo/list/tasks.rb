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

    def done(one_based_task_index)
      t = tasks
      index = one_based_task_index - 1

      t.delete_at(index)
      replace_content(path, t)
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
