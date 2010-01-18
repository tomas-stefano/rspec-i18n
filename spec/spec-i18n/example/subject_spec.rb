require 'spec_helper'

module Spec
  module Example
    describe "implicit subject" do
      
      before(:each) do
        @pt = portuguese_language({'subject' => 'assunto', 'matchers' => {}})
        Subject::ExampleMethods.register_subjects
        @es = spanish_language({'subject' => 'asunto', 'matchers' => {}})
        Subject::ExampleMethods.register_subjects
      end

      it 'should have the subject translated' do
        values = @pt['subject'].split('|')
        values.each do |value_method|
          Subject::ExampleMethods.instance_methods.should be_include(value_method)
        end
      end

      it 'should have the subject translated in spanish' do
        values = @es['subject'].split('|')
        values.each do |value_method|
          Subject::ExampleMethods.instance_methods.should be_include(value_method)
        end
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
