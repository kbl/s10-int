require 'spec_helper'

module Maildo::Message
  describe Validator do

    subject { Validator.new }

    it 'should throw error on invalid title' do
      lambda {
        subject.validate('invelid subject')
      }.should raise_error(MalformedSubjectError)
    end

  end
end
