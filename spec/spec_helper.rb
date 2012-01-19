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
  { from: f, subject: s }
end

CONFIG = Maildo::Config.new do
  set_store_path File.join(File.dirname(__FILE__), 'test-lists')
  set_logger     Logger.new(nil)
end

def empty_test_list_dir
  Dir.new(CONFIG.store_path).each do |f|
    path = File.join(CONFIG.store_path, f)

    is_gitignore = f =~ /^\.gitignore$/
    is_directory = File.directory?(path)

    if !is_gitignore and !is_directory
      File.delete(path)
    end
  end
end

def store_path(list_id)
  File.join(CONFIG.store_path, list_id)
end

def subscribers(list_id)
  Maildo::List::Subscribers.new(CONFIG.store_path, list_id).subscribers
end

def tasks(list_id)
  Maildo::List::Tasks.new(CONFIG.store_path, list_id).tasks
end
