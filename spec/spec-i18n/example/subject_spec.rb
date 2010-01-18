require 'spec_helper'

module Spec
  module Example
    describe "implicit subject" do
      
      before(:each) do
        
      end
      
      describe "with a class" do
        it "returns an instance of the class" do
          group = Class.new(ExampleGroupDouble).describe(Array)
          example = group.new(ExampleProxy.new)
pending
          example.subject.should == []
        end
      end
      
      describe "with a Module" do
        it "returns the Module" do
          group = Class.new(ExampleGroupDouble).describe(Enumerable)
          example = group.new(ExampleProxy.new)
pending
          example.subject.should == Enumerable
        end
      end
    end
  end
end
