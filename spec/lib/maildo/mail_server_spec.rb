require 'spec_helper'

module Maildo
  describe MailServer do

    it 'should retrieve and delete all messages' do
      emails = [email('address', 'subject')]
      provider = prepare_mock(emails)
      server = MailServer.new(provider)

      server.retrieve_and_delete_all.should == [{subject: 'subject', from: 'address'}]
    end

    it 'should retrive only subject and sender from incoming emails' do
      emails = [email('test@email.com', 'subject1'), email('testing@gmail.com', 'subject2')]
      provider = prepare_mock(emails)
      server = MailServer.new(provider)

      server.retrieve_and_delete_all.should == [
        { subject: 'subject1', from: 'test@email.com'}, 
        { subject: 'subject2', from: 'testing@gmail.com' }]
    end

    def prepare_mock(emails)
      provider = mock
      provider.stub!(:all).and_return(emails)
      provider.should_receive(:delete_all)
      provider
    end

    def email(f, s)
      Mail.new do
        from f
        subject s
      end
    end

  end
end
