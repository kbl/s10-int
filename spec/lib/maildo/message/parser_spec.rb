require 'spec_helper'

module Maildo::Message
  describe Parser do

    context 'subscribe' do
      it 'should properly parse subject' do
        m = subject.parse(email('email@domain.com', 'SUBSCRIBE [my_list_id]'))
        m.should be_a Subscribe
        m.sender == 'email@domain.com'
        m.list_id.should == 'my_list_id'
      end
    end

    context 'unsubscribe' do
      it 'should properly parse subject' do
        m = subject.parse(email('email@domain.com', 'UNSUBSCRIBE [list_id]'))
        m.should be_a Unsubscribe
        m.sender == 'email@domain.com'
        m.list_id.should == 'list_id'
      end
    end

    context 'list' do
      it 'should properly parse subject' do
        m = subject.parse(email('test@test.pl', 'LIST [list_id_22]'))
        m.should be_a List
        m.sender == 'test@test.pl'
        m.list_id.should == 'list_id_22'
      end
    end

    context 'add' do
      it 'should properly parse subject' do
        m = subject.parse(email('x@y.z', 'ADD [2xjjyyz] todo message'))
        m.should be_a Add
        m.sender == 'x@y.z'
        m.list_id.should == '2xjjyyz'
        m.body.should == 'todo message'
      end

      it 'should strip spaces from todo message' do
        m = subject.parse(email('a@b.c', 'ADD [2xjjyyz]    <todo message>     '))
        m.body.should == '<todo message>'
      end
    end

    context 'done' do
      it 'should properly parse subject' do
        m = subject.parse(email('xx@yy.pl', 'DONE [list_id] <task id>'))
        m.should be_a Done
        m.sender.should == 'xx@yy.pl'
        m.list_id.should == 'list_id'
        m.task_id.should == '<task id>'
      end
      it 'should strip spaces from task identifier' do
        m = subject.parse(email('a@b.c', 'DONE [x]      #12  '))
        m.task_id.should == '#12'
      end
    end

    context 'malformed subject' do
      it 'should trow error on invalida action' do
        lambda {
          subject.parse(email('zz@pp.pl', 'INVALID_ACTION [id]'))
        }.should raise_error(MalformedSubjectError)
      end
    end

  end
end
