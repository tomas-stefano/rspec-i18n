require 'spec_helper'

module Spec
  module Example
    describe "implicit subject" do
      
      before(:each) do
        @keywords = {'subject' => 'assunto|asunto', 
          'should' => 'deve|deveria',
          'should_not' => 'nao_deve|nao_deveria','matchers' => {}}
        stub_language!("pt", @keywords)
        Subject::ExampleMethods.register_subjects
        @name_methods = Subject::ExampleMethods.instance_methods.to_symbols
      end

      it 'should have the subject translated' do
        [:assunto, :asunto].each do |translated_subject|
          @name_methods.should include(translated_subject)
        end
      end
      
      it "should have the 'should' method translated in subject" do
        [:deve, :deveria].each do |should_method|
          @name_methods.should include(should_method)
        end
      end

      it "should have the should and should_not method trasnlated" do
        [:nao_deve, :nao_deveria].each do |should_not_method|
          @name_methods.should include(should_not_method)
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
        example.asunto.should == [1,2,3]
      end

    end
    
    describe ".its (to access subject's attributes)" do
      
      before(:each) do
        @keywords = {'subject' => 'assunto', 'its' => 'exemplos', 'matchers' => {}}
        stub_language!("pt", @keywords)
        Subject::ExampleGroupMethods.register_subjects
      end
   
      with_sandboxed_options do
         it "passes when expectation should pass" do
           group = Class.new(ExampleGroupDouble).describe(Array)
           child = group.exemplos(:length) { should == 0 }
           child.run(options).should == true
         end
      end
    
    end

  end
end
