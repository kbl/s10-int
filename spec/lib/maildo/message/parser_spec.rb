require 'spec_helper'

module Maildo::Message
  describe Parser do

    subject { Parser.new }

    context 'subscribing' do
      it 'should properly parse subject' do
        message = subject.parse('SUBSCRIBE [my_list_id]')
        message.should be_a Subscription
      end
    end

    it 'should throw error on invalid title' do
      lambda {
        subject.parse('invelid subject')
      }.should raise_error(MalformedSubjectError)
    end

  end
end
