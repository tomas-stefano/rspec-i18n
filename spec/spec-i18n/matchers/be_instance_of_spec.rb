require 'spec_helper'

module Spec
  module Matchers
    describe 'the be_instance_of method' do
      
      before(:each) do
        @keywords = { 'matchers' => { 'be_an_instance_of' => 'ser_instancia_de|ser_instancia'} }
        stub_language!("pt", @keywords)
        Spec::Matchers.register_all_matchers
      end
      
      it "register the be_an_instance_of method" do
        [:ser_instancia_de, :ser_instancia].each do |translated_matcher|
          methods.to_symbols.should include(translated_matcher)
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