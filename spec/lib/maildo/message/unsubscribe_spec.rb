require 'spec_helper'

module Maildo::Message
  describe Unsubscribe do

    after(:each) { empty_test_list_dir }

    it 'should throw error while trying to unsubscribe from list to which sender isnt subscribed' do
      lambda {
        Unsubscribe.new('joe@smith.com', 'abc_list').execute
      }.should raise_error(NotYetSubscribedError)
    end

    it 'should properly unsubscribe user' do
      Subscribe.new('joe@smith.com', 'abc_list').execute
      Subscribe.new('john@lenon.com', 'abc_list').execute
      
      Unsubscribe.new('joe@smith.com', 'abc_list').execute

      subscribers('abc_list').should == ['john@lenon.com']
    end

    it 'should left other lists intact while unsubscribing' do
      Subscribe.new('joe@smith.com', 'abc_list').execute
      Subscribe.new('john@lenon.com', 'xyz_list').execute
      
      Unsubscribe.new('joe@smith.com', 'abc_list').execute

      subscribers('abc_list').should == []
      subscribers('xyz_list').should == ['john@lenon.com']
    end

  end
end
