require 'spec_helper'

module Maildo::Message
  describe List do

    SENDER = 'xx@yy.com'
    LIST_ID = 'bzium99'

    after(:each) { empty_test_list_dir }

    it 'should return access denied response' do
      response = list
      response.subject.should == 'Access denied'
      response.body.should match /Please subscribe to \[#{LIST_ID}\]/
    end

    context 'subscribed' do
      before(:each) { Subscribe.new(SENDER, LIST_ID).execute }

      it 'should return valid response' do
        add_task('learn moonwalk')
        add_task('do 100 pushups in 1 minute')
        add_task('do 101 pushups in 2 minutes')

        response = list
        response.subject.should == "Todo list #{LIST_ID}"
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
      Add.new(SENDER, LIST_ID, task).execute
    end

    def list
      List.new(SENDER, LIST_ID).execute
    end

  end
end
