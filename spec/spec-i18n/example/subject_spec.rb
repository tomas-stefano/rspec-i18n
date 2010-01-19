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

    describe "explicit subject" do
      describe "defined in a top level group" do
        it "replaces the implicit subject in that group" do
          group = Class.new(ExampleGroupDouble).describe(Array)
          group.subject { [1,2,3] }
          example = group.new(ExampleProxy.new)
          example.asunto.should == [1,2,3]
        end
      end
    end

    describe 'defined in a top level group' do
      
      before(:each) do
          @group = Class.new do
            extend  Spec::Example::Subject::ExampleGroupMethods
            include Spec::Example::Subject::ExampleMethods
            class << self
              def described_class
                Array
              end
            end
            def described_class
              self.class.described_class
            end
            
            subject {
              [1,2,3]
            }
          end
        end

      it "is available in a nested group (subclass)" do
        nested_group = Class.new(@group)
        
        example = nested_group.new
        example.assunto.should == [1,2,3]
      end

      it "is available in a doubly nested group (subclass)" do
        nested_group = Class.new(@group)
        doubly_nested_group = Class.new(nested_group)

        example = doubly_nested_group.new
        example.subject.should == [1,2,3]
      end

    end
  end
end
