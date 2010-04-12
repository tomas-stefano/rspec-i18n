require 'spec_helper'

module Spec
  module Matchers
    describe "[actual.should] be_close(expected, delta)" do
      
      before(:each) do
        @keywords = {'matchers' => { 'be_close' => 'estar_perto|estar_proximo'} }
        stub_language!("pt", @keywords)
        Spec::Matchers.register_all_matchers
      end
      
      it "should register the be_close matcher" do
        [:estar_perto, :estar_proximo].each do |translate_matcher|
          methods.to_symbols.should include translate_matcher          
        end
      end
      
      it "matches when actual == expected" do
        estar_perto(5.0, 0.5).matches?(5.0).should be_true
        estar_proximo(5.0, 0.5).matches?(5.0).should be_true
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