require 'spec_helper'

# The same class in rspec specs file
class Substance
  def initialize exists, description
    @exists = exists
    @description = description
  end
  def exist?(arg=nil)
    @exists
  end
end

module Spec
  module Matchers
    
    describe "exist matcher" do
      
      before(:each) do
        @keywords = {'matchers' => {'exist' => 'existir|existe'}}
        stub_language!("pt", @keywords)
        Spec::Matchers.register_all_matchers
        @real = Substance.new true, 'something real'
        @imaginary = Substance.new false, 'something imaginary'
      end
      
      it 'should register the exist method translated' do
        [:existir, :existe].each do |translated_matcher|
          methods.to_symbols.should include(translated_matcher)
        end
      end
      
      it "passes if target exists" do
        @real.should existir
      end
      
      it "fails if target does not exist" do
        lambda { @imaginary.should exist }.should raise_error
      end
      
    end
    
  end
end