require 'spec_helper'

module Maildo::Message
  describe Done do

    after(:each) { empty_test_list_dir }

    it 'should throw error on changing task in unsubscribed list' do
      lambda {
        Done.new('john@lenon.com', 'funny_list_id', 'task').execute
      }.should raise_error NotYetSubscribedError
    end

  end
end
