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
          example.assunto.should == []
        end
      end
      
      describe "with a Module" do
        it "returns the Module" do
          group = Class.new(ExampleGroupDouble).describe(Enumerable)
          example = group.new(ExampleProxy.new)
          example.assunto.should == Enumerable
        end
      end
    end
  end
end