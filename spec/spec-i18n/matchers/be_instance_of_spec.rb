require 'spec_helper'

module Spec
  module Matchers
    describe 'the be_instance_of method' do
      
      before(:each) do
        @expected_matcher = { 'matchers' => { 'be_an_instance_of' => 'ser_instancia_de'} }
        portuguese_language(@expected_matcher)
        Spec::Matchers.register_all_matchers
      end
      
      it "register the be_an_instance_of method" do
        values = @expected_matcher['matchers']['be_an_instance_of'].split('|')
        values.each do |value_method|
          Object.instance_methods.should be_include(value_method)
        end
      end
      
      it "passes if actual is instance of expected class" do
        5.should send(:ser_instancia_de, Fixnum)
      end
      
      it "fails if actual is instance of subclass of expected class" do
        lambda { 
          5.should send(:ser_instancia_de, Numeric)          
        }.should raise_error
      end
      
    end
  end
end