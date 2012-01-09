require 'spec_helper'

module Maildo
  describe Dispatcher do

    subject { Dispatcher.new }

    it 'should throw error on bad subject pattern' do
      pending
      mail = Mail.new
      mail.subject = 'invalid subject'
      lambda {
        subject.dispatch(mail)
      }.should raise_error(Message::MalformedSubjectError)
    end
  end
end
