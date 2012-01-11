require 'spec_helper'

module Maildo::Message
  describe Done do

    SENDER = 'joe@smith.com'
    LIST_ID = 'id7'

    after(:each) { empty_test_list_dir }

    it 'should return access denied response' do
      r = done('task')
      r.subject.should == 'Access denied'
      r.body.should match /Please subscribe to \[#{LIST_ID}\]/
      r.to.should == SENDER
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
        r = done('1')
        r.subject.should == 'Task done'
        r.body.should == 'Task with number 1 (read whole internet) was done.'
        r.to.should == SENDER
      end

      context 'illegal task identifier' do

        before(:each) { add_task('task') }

        it 'should throw error for index <= 0' do
          r = done('0')
          r.subject.should == 'Illegal action'
          r.body.should == 'Task identifier [0] is illegal.'
        end

        it 'should throw error for index > task.length' do
          r = done('2')
          r.subject.should == 'Illegal action'
          r.body.should == 'Task identifier [2] is illegal.'
        end

        it 'should do sth on wrong task identifier' do
          r = done('1wrong number id')
          r.subject.should == 'Illegal action'
          r.body.should == 'Task identifier [1wrong number id] is illegal.'
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
