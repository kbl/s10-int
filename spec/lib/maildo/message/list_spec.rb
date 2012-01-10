require 'spec_helper'

module Maildo::Message
  describe List do

    after(:each) { empty_test_list_dir }

    it 'should throw error on listing unsubscribed list' do
      lambda {
        List.new('john@lenon.com', 'funny_list_id').execute
      }.should raise_error NotYetSubscribedError
    end

  end
end
