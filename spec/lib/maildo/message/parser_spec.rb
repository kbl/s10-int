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

    context 'add' do
      it 'should properly parse subject' do
        m = subject.parse('ADD [xjjyyz] todo message')
        m.should be_a Add
        m.list_id.should == 'xjjyyz'
        m.body.should == 'todo message'
      end

      it 'should strip spaces from todo message' do
        m = subject.parse('ADD [2xjjyyz]    <todo message>     ')
        m.body.should == '<todo message>'
      end
    end

    it 'should throw error on invalid title' do
      lambda {
        subject.parse('invelid subject')
      }.should raise_error(MalformedSubjectError)
    end

  end
end
