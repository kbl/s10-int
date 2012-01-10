require 'maildo'

Mail.defaults do
  delivery_method :test
  retriever_method :test
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

def email(f, s)
  Mail.new do
    from f
    subject s
  end
end

module Maildo::Config

  TODO_LISTS_PATH = File.join(File.dirname(__FILE__), 'test-lists')

end

def empty_test_list_dir
  Dir.new(Maildo::Config::TODO_LISTS_PATH).each do |f|
    path = File.join(Maildo::Config::TODO_LISTS_PATH, f)

    is_gitignore = f =~ /^\.gitignore$/
    is_directory = File.directory?(path)

    if !is_gitignore and !is_directory
      File.delete(path)
    end
  end
end

def subscribers(list_id)
  Maildo::List::Subscribers.new(list_id).subscribers
end

def tasks(list_id)
  Maildo::List::Tasks.new(list_id).tasks
end
