require 'spec_helper'

module Maildo::Message
  describe Add do

    let(:sender) { 'marcin@pietraszek.com' }
    let(:list_id) { '22xx_xx22' }

    after(:each) { empty_test_list_dir }

    it 'should return access denied response' do
      response = add_task('task')
      response.subject.should == 'Access denied'
      response.body.should match /Please subscribe to \[#{list_id}\]/
      response.to.should == sender
    end

    context 'subscribed' do
      before(:each) { Subscribe.new(sender, list_id).execute }

      it 'should add tasks to list' do
        add_task('task')
        add_task('really hard task')

        tasks(list_id).should == ['task', 'really hard task']
      end

      it 'should return response indicating successfull task addition' do
        response = add_task('aa_bb cc_dd')
        response.subject.should == 'Task added'
        response.body.should == "Task aa_bb cc_dd successfully added to list #{list_id}."
        response.to.should == sender
      end
    end

    def add_task(task)
      Add.new(sender, list_id, task).execute
    end

  end
end
