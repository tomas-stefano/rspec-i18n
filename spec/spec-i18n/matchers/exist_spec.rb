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
        @expected_matcher = {'matchers' => {'exist' => 'existir'}}
        portuguese_language(@expected_matcher)
        Spec::Matchers.register_exist_matcher
        @real = Substance.new true, 'something real'
        @imaginary = Substance.new false, 'something imaginary'
      end
      
      it 'should register the exist method translated' do
        values = @expected_matcher['matchers']['exist'].split('|')
        values.each do |value_method|
          Object.instance_methods.should be_include(value_method)
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