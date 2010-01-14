require 'spec_helper'

module Spec
  module Matchers
    describe "eql" do
      
      before(:each) do
        @expected_matcher = {'matchers' => {'eql' => 'igl'}}
        portuguese_language(@expected_matcher)
        Spec::Matchers.register_all_matchers
      end
      
      it "should have eql matchers translated" do
        eql_word = @expected_matcher['matchers']['eql']
        1.methods.should be_include(eql_word)
      end
      
      it "should have eql? matchers translated" do
        eql_word = @expected_matcher['matchers']['eql'] + '?'
        1.methods.should be_include(eql_word)
      end
      
      it "should match when actual.eql?(expected)" do
        1.should igl(1)
      end
      
      it "should not match when !actual.eql?(expected)" do
        1.should_not igl(2)
      end
      
    end
  end
end