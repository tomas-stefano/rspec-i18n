require 'spec_helper'

module Spec
  module Matchers
    describe 'the be_kind_of method' do
      
      before(:each) do
        @keywords = { 'matchers' => { 'be_a_kind_of' => 'ser_do_tipo'} }
        stub_language!("pt", @keywords)
        Spec::Matchers.register_all_matchers
      end
      
      it "register the be_an_instance_of method" do
        methods.to_symbols.should include(:ser_do_tipo)
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