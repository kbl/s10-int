require 'spec_helper'

module Maildo::Message
  describe List do

    SENDER = 'xx@yy.com'
    LIST_ID = 'bzium99'

    after(:each) { empty_test_list_dir }

    it 'should return access denied response' do
      response = List.new(SENDER, LIST_ID).execute
      response.subject.should == 'Access denied'
      response.body.should match /Please subscribe to \[#{LIST_ID}\]/
    end

    context 'subscribed' do
      before(:each) { Subscribe.new(SENDER, LIST_ID).execute }

      it 'should list all tasks' do
        add_task('task1')
        add_task('super hard task')

        List.new(SENDER, LIST_ID).execute.should == ['task1', 'super hard task']
      end
    end

    def add_task(task)
      Add.new(SENDER, LIST_ID, task).execute
    end

  end
end
