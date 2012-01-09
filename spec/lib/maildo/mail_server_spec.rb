require 'spec_helper'

module Maildo
  describe MailServer do

    it 'should retrieve and delete all messages' do
      provider = mock
      provider.stub!(:all).and_return(['test'])
      provider.should_receive(:delete_all)

      server = MailServer.new(provider)

      server.retrieve_and_delete_all.should == ['test']
    end

  end
end
