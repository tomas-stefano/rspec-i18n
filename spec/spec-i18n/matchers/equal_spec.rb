require "spec_helper"

module Spec
  module Matchers
    
    describe 'equal' do
      
      before(:each) do
        @keywords = {'matchers' => {'equal' => 'igual|igual_a'}}
        stub_language!("pt", @keywords)
        Spec::Matchers.register_all_matchers
      end
      
      it 'should translated the methods for the value equal matcher' do
        [:igual, :igual_a].each do |translated_matcher|
          methods.to_symbols.should include(translated_matcher)
        end
      end
      
      it "should translated the methods with '?' char" do
        [:igual?, :igual_a?].each do |translated_method|
          methods.to_symbols.should include(translated_method)
        end
      end
      
      it "should match when actual.equal?(expected)" do
        1.should igual(1)
      end
      
      it "should be true when actual.equal?(expected) with ?" do
        1.igual?(1).should be_true
        1.should be_igual(1)
      end
      
      it "should not match when !actual.equal?(expected)" do
        1.should_not be_igual_a("1")
      end
      
      it "should not match when !actual.equal?(expected) with ?" do
        1.igual_a?(1).should be_true
        1.should be_igual_a(1)
      end
      
    end
    
  end
end