require 'spec_helper'

module Spec
  module Example
    describe "implicit subject" do
      
      before(:each) do
        @pt = portuguese_language({'subject' => 'assunto', 'should' => 'deve',
                                    'should_not' => 'nao_deve','matchers' => {}})
        Subject::ExampleMethods.register_subjects
        @es = spanish_language({'subject' => 'asunto', 'should' => 'deve',
                                'should_not' => 'nao_deve', 'matchers' => {}})
        Subject::ExampleMethods.register_subjects
      end

      it 'should have the subject translated' do
        values = @pt['subject'].split('|')
        values << @es['subject'].split('|')
        values.flatten.each do |value_method|
          methods = Subject::ExampleMethods.instance_methods.all_to_symbols
          methods.should be_include(value_method.to_sym)
        end
      end

      it "should have the should and should_not method trasnlated" do
        values = @pt['should'].split('|')
        other_values = @pt['should_not'].split('|')
        values << other_values
        values.flatten.each do |value_method|
          methods= Subject::ExampleMethods.instance_methods.all_to_symbols
          methods.should be_include(value_method.to_sym)
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
    
    describe ".its (to access subject's attributes)" do
      
      before(:each) do
        @its_examples = {'subject' => 'assunto', 'its' => 'exemplos', 'matchers' => {}}
        @pt = portuguese_language(@its_examples)
        Subject::ExampleGroupMethods.register_subjects
        @es = spanish_language({'subject' => 'assunto', 'its' => 'ejemplos', 'matchers' => {}})
        Subject::ExampleGroupMethods.register_subjects
      end
   
     with_sandboxed_options do
        it "passes when expectation should pass" do
          group = Class.new(ExampleGroupDouble).describe(Array)
          child = group.exemplos(:length) { should == 0 }
          child.run(options).should == true
        end
        
        it "fails when expectation should fail" do
          group = Class.new(ExampleGroupDouble).describe(Array)
          child = group.ejemplos(:length) { should == 1 }
          child.run(options).should == false
        end
      end
    end

  end
end
