require 'spec_helper'

module Spec
  module Matchers
    describe "eql" do
      
      before(:each) do
        @keywords = {'matchers' => {'eql' => 'igl'}}
        stub_language!("pt", @keywords)
        Spec::Matchers.register_all_matchers
      end
      
      it "should have eql matchers translated" do
        methods.to_symbols.should include(:igl)
      end
      
      it "should have eql? matchers translated" do
        methods.to_symbols.should include(:igl?)
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