require 'spec_helper'

module Maildo::Message
  describe Handler do

    subject { Handler.new }

    context 'subscribe' do
      it 'should properly handle subject' do
        m = subject.handle(email('email@domain.com', 'SUBSCRIBE [my_list_id]'))
        m.should be_a Subscribe
        m.sender == 'email@domain.com'
        m.list_id.should == 'my_list_id'
      end
    end

    context 'unsubscribe' do
      it 'should properly handle subject' do
        m = subject.handle(email('email@domain.com', 'UNSUBSCRIBE [list_id]'))
        m.should be_a Unsubscribe
        m.sender == 'email@domain.com'
        m.list_id.should == 'list_id'
      end
    end

    context 'list' do
      it 'should properly handle subject' do
        m = subject.handle(email('test@test.pl', 'LIST [list_id_22]'))
        m.should be_a List
        m.sender == 'test@test.pl'
        m.list_id.should == 'list_id_22'
      end
    end

    context 'add' do
      it 'should properly handle subject' do
        m = subject.handle(email('x@y.z', 'ADD [2xjjyyz] todo message'))
        m.should be_a Add
        m.sender == 'x@y.z'
        m.list_id.should == '2xjjyyz'
        m.body.should == 'todo message'
      end

      it 'should strip spaces from todo message' do
        m = subject.handle(email('a@b.c', 'ADD [2xjjyyz]    <todo message>     '))
        m.body.should == '<todo message>'
      end
    end

    context 'done' do
      it 'should properly handle subject' do
        m = subject.handle(email('xx@yy.pl', 'DONE [list_id] <task id>'))
        m.should be_a Done
        m.sender.should == 'xx@yy.pl'
        m.list_id.should == 'list_id'
        m.task_id.should == '<task id>'
      end
      it 'should strip spaces from task identifier' do
        m = subject.handle(email('a@b.c', 'DONE [x]      #12  '))
        m.task_id.should == '#12'
      end
    end

    context 'malformed subject' do
      it 'should return no-op message' do
        m = subject.handle(email('zz@pp.pl', 'INVALID_ACTION [id]'))
        response = m.execute
        response.subject.should == 'Illegal message'
        response.body.should == 'Message [INVALID_ACTION [id]] could not be processed successfully.'
        response.to.should == 'zz@pp.pl'
      end

      it 'should return no-op message for invalid list id (with same name as subscribers file)' do
        m =  subject.handle(email('zz@pp.pl', 'ADD [id-subscribers] task'))
        response = m.execute
        response.subject.should == 'Illegal message'
        response.body.should == 'Message [ADD [id-subscribers] task] could not be processed successfully.'
        response.to.should == 'zz@pp.pl'
      end
    end

  end
end
