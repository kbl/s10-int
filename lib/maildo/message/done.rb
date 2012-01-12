module Maildo
  module Message
    class Done < TasksAwareMessage
      
      attr_reader :task_id

      def initialize(sender, list_id, task_id)
        super(sender, list_id)
        @task_id = task_id
      end

      def execute
        response = super
        return response if response

        begin
          task = @tasks.done(task_id)
        rescue Maildo::List::IllegalTaskIdentifierError
          return response('Illegal action', "Task identifier [#{task_id}] is illegal.")
        end

        response('Task done', "Task with number #{task_id} (#{task}) was done.")
      end

    end
  end
end
