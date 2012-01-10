require 'spec_helper'

module Maildo
  describe Dispatcher do

    it 'should throw error on bad subject pattern' do
      mail_server = mock
      mail_server.stub!(:retrieve_and_delete_all).and_return([email('from@sender.com', 'illegal subject')])
      dispatcher = Dispatcher.new(mail_server)

      lambda {
        dispatcher.tick()
      }.should raise_error(Message::MalformedSubjectError)
    end
  end
end
