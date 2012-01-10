require 'spec_helper'

module Maildo::Message
  describe Done do

    SENDER = 'joe@smith.com'
    LIST_ID = 'id7'

    after(:each) { empty_test_list_dir }

    it 'should throw error on changing task in unsubscribed list' do
      lambda {
        Done.new(SENDER, LIST_ID, 'task').execute
      }.should raise_error NotYetSubscribedError
    end

    context 'subscribed' do
      before(:each) { Subscribe.new('joe@smith.com', 'id7').execute }

      it 'should done task by 1 based index' do
        pending
        add_task('task')
        add_task('to be done')
        add_task('really hard task')

        tasks(LIST_ID).should == ['task', 'to be done', 'really hard task']
        Done.new(SENDER, LIST_ID, '2').execute
        tasks(LIST_ID).should == ['task', 'really hard task']
      end
    end

    def add_task(task)
        Add.new(SENDER, LIST_ID, task).execute
    end

  end
end
