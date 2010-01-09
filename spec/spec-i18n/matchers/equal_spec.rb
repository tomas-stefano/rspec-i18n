require "spec_helper"

module Spec
  module Matchers
    describe 'equal' do
      before(:each) do
        @expected_matcher = {'matchers' => {'equal' => 'igual|igual_a'}}
        portuguese_language(@expected_matcher)
        Spec::Matchers.register_equal_matcher
      end
      
      it 'should register the methods for the value equal matcher' do
        values = @expected_matcher['matchers']['equal'].split('|') 
        values.each { |method_name| Object.instance_methods.should be_include(method_name) }
      end
      
    end
  end
end