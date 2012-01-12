require 'spec_helper'

module Maildo::Message
  describe Unsubscribe do

    SENDER = 'joe@smith.com'
    LIST_ID = 'abc_list'

    after(:each) { empty_test_list_dir }

    it 'should return access denied response while trying to unsubscribe from list to which sender is not subscribed' do
      r = unsubscribe
      r.subject.should == 'Access denied'
      r.body.should match /Please subscribe to \[#{LIST_ID}\]/
      r.to.should == SENDER
    end
    
    it 'should return succesfull unsubscription response' do
      Subscribe.new(SENDER, LIST_ID).execute
      r = unsubscribe
      r.subject.should == 'Unsubscribed successfully'
      r.body.should == "You are now unsubscribed from list [#{LIST_ID}]."
      r.to.should == SENDER
    end

    it 'should properly unsubscribe user' do
      Subscribe.new(SENDER, LIST_ID).execute
      Subscribe.new('john@lenon.com', LIST_ID).execute
      
      unsubscribe

      subscribers(LIST_ID).should == ['john@lenon.com']
    end

    it 'should left other lists intact while unsubscribing' do
      Subscribe.new(SENDER, LIST_ID).execute
      Subscribe.new('john@lenon.com', 'xyz_list').execute
      
      unsubscribe

      subscribers(LIST_ID).should == []
      subscribers('xyz_list').should == ['john@lenon.com']
    end

    context 'file deletion' do

      let(:store_path) { Maildo::List::Store.path(LIST_ID) }

      it 'should remove todo with subscribers files after last subscribent request unsubscription' do
        Subscribe.new(SENDER, LIST_ID).execute
        Add.new(SENDER, LIST_ID, 'task').execute

        File.exists?(store_path).should == true
        subscribers(LIST_ID).length.should == 1

        unsubscribe

        File.exists?(store_path).should == false
      end

      it 'shouldnt remove files if subscribers left' do
        Subscribe.new(SENDER, LIST_ID).execute
        Subscribe.new('xx@yy.pl', LIST_ID).execute

        File.exists?(store_path).should == true
        subscribers(LIST_ID).length.should == 2

        unsubscribe

        File.exists?(store_path).should == true
        subscribers(LIST_ID).length.should == 1
      end
    end

    def unsubscribe
      Unsubscribe.new(SENDER, LIST_ID).execute
    end

  end
end
