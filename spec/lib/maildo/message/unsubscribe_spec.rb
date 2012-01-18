require 'spec_helper'

module Maildo::Message
  describe Unsubscribe do

    let(:sender) { 'joe@smith.com' }
    let(:list_id) { 'abc_list' }

    after(:each) { empty_test_list_dir }

    it 'should return access denied response while trying to unsubscribe from list to which sender is not subscribed' do
      r = unsubscribe
      r.subject.should == 'Access denied'
      r.body.should match /Please subscribe to \[#{list_id}\]/
      r.to.should == sender
    end
    
    it 'should return succesfull unsubscription response' do
      Subscribe.new(CONFIG, sender, list_id).execute
      r = unsubscribe
      r.subject.should == 'Unsubscribed successfully'
      r.body.should == "You are now unsubscribed from list [#{list_id}]."
      r.to.should == sender
    end

    it 'should properly unsubscribe user' do
      Subscribe.new(CONFIG, sender, list_id).execute
      Subscribe.new(CONFIG, 'john@lenon.com', list_id).execute
      
      unsubscribe

      subscribers(list_id).should == ['john@lenon.com']
    end

    it 'should left other lists intact while unsubscribing' do
      Subscribe.new(CONFIG, sender, list_id).execute
      Subscribe.new(CONFIG, 'john@lenon.com', 'xyz_list').execute
      
      unsubscribe

      subscribers(list_id).should == []
      subscribers('xyz_list').should == ['john@lenon.com']
    end

    context 'file deletion' do

      let(:path) { store_path(list_id) }

      it 'should remove todo with subscribers files after last subscribent request unsubscription' do
        Subscribe.new(CONFIG, sender, list_id).execute
        Add.new(CONFIG, sender, list_id, 'task').execute

        File.exists?(path).should == true
        subscribers(list_id).length.should == 1

        unsubscribe

        File.exists?(path).should == false
      end

      it 'shouldnt remove files if subscribers left' do
        Subscribe.new(CONFIG, sender, list_id).execute
        Subscribe.new(CONFIG, 'xx@yy.pl', list_id).execute

        File.exists?(path).should == true
        subscribers(list_id).length.should == 2

        unsubscribe

        File.exists?(path).should == true
        subscribers(list_id).length.should == 1
      end
    end

    def unsubscribe
      Unsubscribe.new(CONFIG, sender, list_id).execute
    end

  end
end
