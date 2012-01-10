require 'spec_helper'

module Maildo::Message
  describe Subscribe do

    after(:each) { empty_test_list_dir }

    it 'should create subscribers file with proper name' do
      s = Subscribe.new('joe@smith.com', 'list_id')
      path =  File.join(Maildo::Config::TODO_LISTS_PATH, 'list_id-subscribers')

      File.exists?(path).should == false
      s.execute
      File.exists?(path).should == true
    end

    it 'should throw error if user is already subscribed' do
      s = Subscribe.new('joe@smith.com', 'list_id')
      s.execute
      lambda {
        s.execute
      }.should raise_error(AlreadySubscribedError)
    end

    it 'should properly subscribe many users to same list' do
      Subscribe.new('joe@smith.com', 'list_id').execute
      Subscribe.new('joe@lenon.com', 'list_id').execute

      subscribers('list_id').should == %w(joe@smith.com joe@lenon.com)
    end

    it 'should properly subscribe many users to different lists' do
      Subscribe.new('joe@smith.com', 'list_id').execute
      Subscribe.new('joe@smith.com', 'list_id2').execute
      Subscribe.new('joe@lenon.com', 'list_id').execute

      subscribers('list_id').should == %w(joe@smith.com joe@lenon.com)
      subscribers('list_id2').should == ['joe@smith.com']
    end

  end
end
