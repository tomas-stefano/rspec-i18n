require 'spec_helper'

module Spec
  module Matchers
    describe "[actual.should] be_close(expected, delta)" do
      
      before(:each) do
        @expected_matcher = {'matchers' => { 'be_close' => 'estar_perto'} }
        portuguese_language(@expected_matcher)
        Spec::Matchers.register_all_matchers
      end
      
      it "should register the be_close matcher" do
        values = @expected_matcher['matchers']['be_close'].split('|')
        values.each do |value_method|
          Object.instance_methods.should be_include(value_method)
        end
      end
      
      it "matches when actual == expected" do
        estar_perto(5.0, 0.5).matches?(5.0).should be_true
      end
      
      it "matches when actual < (expected + delta)" do
        estar_perto(5.0, 0.5).matches?(5.49).should be_true
      end
      
      it "does not match when actual == (expected - delta)" do
        estar_perto(5.0, 0.5).matches?(4.5).should be_false
      end
      it "does not match when actual < (expected - delta)" do
        estar_perto(5.0, 0.5).matches?(4.49).should be_false
      end
      it "does not match when actual == (expected + delta)" do
        estar_perto(5.0, 0.5).matches?(5.5).should be_false
      end
      
    end
  end
end