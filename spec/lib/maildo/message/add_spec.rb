require 'spec_helper'

module Maildo::Message
  describe Add do

    after(:each) { empty_test_list_dir }

    it 'should throw error on adding task to unsubscribed list' do
      lambda {
        Add.new('john@lenon.com', 'funny_list_id', 'task').execute
      }.should raise_error NotYetSubscribedError
    end

    context 'subscribed' do
      before(:each) { Subscribe.new('joe@smith.com', 'funny_list_id').execute }

      it 'should add tasks to list' do
        Add.new('joe@smith.com', 'funny_list_id', 'task').execute
        Add.new('joe@smith.com', 'funny_list_id', 'really hard task').execute

        tasks('funny_list_id').should == ['task', 'really hard task']
      end
    end

  end
end
