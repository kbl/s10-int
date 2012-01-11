require 'spec_helper'

module Maildo::Message
  describe Unsubscribe do

    SENDER = 'joe@smith.com'
    LIST_ID = 'abc_list'

    after(:each) { empty_test_list_dir }

    it 'should return access denied response while trying to unsubscribe from list to which sender is not subscribed' do
      response = Unsubscribe.new(SENDER, LIST_ID).execute
      response.subject.should == 'Access denied'
      response.body.should match /Please subscribe to \[#{LIST_ID}\]/
    end

    it 'should properly unsubscribe user' do
      Subscribe.new(SENDER, LIST_ID).execute
      Subscribe.new('john@lenon.com', LIST_ID).execute
      
      Unsubscribe.new(SENDER, LIST_ID).execute

      subscribers(LIST_ID).should == ['john@lenon.com']
    end

    it 'should left other lists intact while unsubscribing' do
      Subscribe.new(SENDER, LIST_ID).execute
      Subscribe.new('john@lenon.com', 'xyz_list').execute
      
      Unsubscribe.new(SENDER, LIST_ID).execute

      subscribers(LIST_ID).should == []
      subscribers('xyz_list').should == ['john@lenon.com']
    end

  end
end
