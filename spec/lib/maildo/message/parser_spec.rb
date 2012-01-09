require 'spec_helper'

module Maildo::Message
  describe Parser do

    subject { Parser.new }

    context 'subscribe' do
      it 'should properly parse subject' do
        message = subject.parse('SUBSCRIBE [my_list_id]')
        message.should be_a Subscribe
        message.list_id.should == 'my_list_id'
      end
    end

    context 'unsubscribe' do
      it 'should properly parse subject' do
        message = subject.parse('UNSUBSCRIBE [list_id]')
        message.should be_a Unsubscribe
        message.list_id.should == 'list_id'
      end
    end

    context 'list' do
      it 'should properly parse subject' do
        message = subject.parse('LIST [list_id_22]')
        message.should be_a List
        message.list_id.should == 'list_id_22'
      end
    end

    context 'add' do
      it 'should properly parse subject' do
        m = subject.parse('ADD [2xjjyyz] todo message')
        m.should be_a Add
        m.list_id.should == '2xjjyyz'
        m.body.should == 'todo message'
      end

      it 'should strip spaces from todo message' do
        m = subject.parse('ADD [2xjjyyz]    <todo message>     ')
        m.body.should == '<todo message>'
      end
    end

    context 'done' do
      it 'should properly parse subject' do
        m = subject.parse('DONE [list_id] <task id>')
        m.should be_a Done
        m.list_id.should == 'list_id'
        m.task_id.should == '<task id>'
      end
      it 'should strip spaces from task identifier' do
        m = subject.parse('DONE [x]      #12  ')
        m.task_id.should == '#12'
      end
    end

    context 'malformed subject' do
      it 'should trow error on invalida action' do
        lambda {
          subject.parse('INVALID_ACTION [id]')
        }.should raise_error(MalformedSubjectError)
      end
    end

  end
end
