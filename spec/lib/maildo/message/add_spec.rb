require 'spec_helper'

module Maildo::Message
  describe Add do

    SENDER = 'marcin@pietraszek.com'
    LIST_ID = '22xx_xx22'

    after(:each) { empty_test_list_dir }

    it 'should return access denied response' do
      response = add_task('task')
      response.subject.should == 'Access denied'
      response.body.should match /Please subscribe to \[#{LIST_ID}\]/
      response.to.should == SENDER
    end

    context 'subscribed' do
      before(:each) { Subscribe.new(SENDER, LIST_ID).execute }

      it 'should add tasks to list' do
        add_task('task')
        add_task('really hard task')

        tasks(LIST_ID).should == ['task', 'really hard task']
      end

      it 'should return response indicating successfull task addition' do
        response = add_task('aa_bb cc_dd')
        response.subject.should == 'Task added'
        response.body.should == "Task aa_bb cc_dd successfully added to list #{LIST_ID}."
        response.to.should == SENDER
      end
    end

    def add_task(task)
      Add.new(SENDER, LIST_ID, task).execute
    end

  end
end
