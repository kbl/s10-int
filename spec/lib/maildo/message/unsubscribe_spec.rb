require 'spec_helper'

module Maildo::Message
  describe Unsubscribe do

    it 'should throw error while trying to unsubscribe from list to which sender isnt subscribed' do
      lambda {
        Unsubscribe.new('joe@smith.com', 'abc_list').execute
      }.should raise_error(NotYetSubscribedError)
    end

  end
end
