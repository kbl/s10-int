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
    end

    context 'subscribed' do
      before(:each) { Subscribe.new(SENDER, LIST_ID).execute }

      it 'should add tasks to list' do
        add_task('task')
        add_task('really hard task')

        tasks(LIST_ID).should == ['task', 'really hard task']
      end
    end

    def add_task(task)
      Add.new(SENDER, LIST_ID, task).execute
    end

  end
end
