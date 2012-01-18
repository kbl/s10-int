require 'spec_helper'

module Maildo::Message
  describe List do

    let(:sender) { 'xx@yy.com' }
    let(:list_id) { 'bzium99' }

    after(:each) { empty_test_list_dir }

    it 'should return access denied response' do
      response = list
      response.subject.should == 'Access denied'
      response.body.should match /Please subscribe to \[#{list_id}\]/
      response.to.should == sender
    end

    context 'subscribed' do
      before(:each) { Subscribe.new(CONFIG, sender, list_id).execute }

      it 'should return valid response' do
        add_task('learn moonwalk')
        add_task('do 100 pushups in 1 minute')
        add_task('do 101 pushups in 2 minutes')

        response = list
        response.subject.should == "Todo list #{list_id}"
        response.to.should == sender
        response.body.should == 
<<-STR
List contains following tasks:

1. learn moonwalk
2. do 100 pushups in 1 minute
3. do 101 pushups in 2 minutes
STR

      end
    end

    def add_task(task)
      Add.new(CONFIG, sender, list_id, task).execute
    end

    def list
      List.new(CONFIG, sender, list_id).execute
    end

  end
end
