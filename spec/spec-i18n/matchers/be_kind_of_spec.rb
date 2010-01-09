require 'spec_helper'

module Spec
  module Matchers
    describe 'the be_kind_of method' do
      
      before(:each) do
        @expected_matcher = { 'matchers' => { 'be_a_kind_of' => 'ser_do_tipo'} }
        portuguese_language(@expected_matcher)
        Spec::Matchers.register_be_a_kind_of_matcher
      end
      
      it "register the be_an_instance_of method" do
        values = @expected_matcher['matchers']['be_a_kind_of'].split('|')
        values.each do |value_method|
          Object.instance_methods.should be_include(value_method)
        end
      end
      
      it "passes if actual is instance of expected class" do
        5.should send(:ser_do_tipo, Fixnum)
      end

      it "passes if actual is instance of subclass of expected class" do
        5.should send(:ser_do_tipo, Numeric)
      end

      it "fails with failure message for should unless actual is kind of expected class" do
        lambda { 
          "foo".should send(:ser_do_tipo, Array) 
        }.should raise_error
      end
      
    end
    
  end
end