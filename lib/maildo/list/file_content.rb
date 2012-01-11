module Maildo
  module List
    module FileContent

      def content(path)
        content = []

        if File.exists?(path)
          File.open(path) do |f|
            f.each { |line| content << line.chomp }
          end
        end

        content
      end

      def replace_content(path, content)
        File.open(path, 'w') do |f|
          content.each { |subscriber| f.puts(subscriber) }
        end
      end

    end
  end
end
