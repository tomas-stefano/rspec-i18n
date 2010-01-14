require "spec_helper"

module Spec
  module Matchers
    describe 'equal' do
      before(:each) do
        @expected_matcher = {'matchers' => {'equal' => 'igual|igual_a'}}
        portuguese_language(@expected_matcher)
        Spec::Matchers.register_all_matchers
      end
      
      it 'should register the methods for the value equal matcher' do
        values = @expected_matcher['matchers']['equal'].split('|') 
        values.each { |method_name| Object.instance_methods.should be_include(method_name) }
      end
      
      it "should match when actual.equal?(expected)" do
        1.should igual(1)
      end

      it "should not match when !actual.equal?(expected)" do
        1.should_not igual_a("1")
      end
    end
  end
end