require 'spec_helper'

module Maildo::Message
  describe Done do

    SENDER = 'joe@smith.com'
    LIST_ID = 'id7'

    after(:each) { empty_test_list_dir }

    it 'should return access denied response' do
      response = Done.new(SENDER, LIST_ID, 'task').execute
      response.subject.should == 'Access denied'
      response.body.should match /Please subscribe to \[#{LIST_ID}\]/
    end

    context 'subscribed' do
      before(:each) { Subscribe.new(SENDER, LIST_ID).execute }

      it 'should done task by 1 based index' do
        add_task('task')
        add_task('to be done')
        add_task('really hard task')

        tasks(LIST_ID).should == ['task', 'to be done', 'really hard task']
        done('2')
        tasks(LIST_ID).should == ['task', 'really hard task']
      end

      it 'should return valid response object' do
        add_task('read whole internet')
        response = done('1')
        response.subject.should == 'Task done'
        response.body.should == 'Task with number 1 (read whole internet) was done.'
      end

      context 'illegal task identifier' do
        it 'should throw error for index <= 0' do
          add_task('task')
          lambda {
            done('0')
          }.should raise_error Maildo::List::IllegalTaskIdentifierError
        end

        it 'should throw error for index > task.length' do
          add_task('task')
          lambda {
            done('2')
          }.should raise_error Maildo::List::IllegalTaskIdentifierError
        end

        it 'should do sth on wrong task identifier' do
          pending
          add_task('task')
          lambda {
            done('1wrong numer id')
          }.should raise_error Maildo::List::IllegalTaskIdentifierError
        end
      end
    end

    def add_task(task)
      Add.new(SENDER, LIST_ID, task).execute
    end

    def done(task_id)
      Done.new(SENDER, LIST_ID, task_id).execute
    end

  end
end
