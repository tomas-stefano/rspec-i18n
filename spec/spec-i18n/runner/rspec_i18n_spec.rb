require 'spec_helper'

module Spec
  module Runner
    describe Configuration do
      with_sandboxed_options do
        with_sandboxed_config do
          describe "#spec_language" do

            it "should default a english language for nil" do
              config.spec_language(nil).should == "en"
            end

            it "should return a pt language" do
              config.spec_language(:pt).should == "pt"
            end

            it "should return a es language using a Symbol" do
              config.spec_language(:es).should == "es"
            end
            
            it "should return a en language for the nil parameter" do
              config.spec_language(nil)
              config.language.should == "en"
            end

            it "should set the portuguese language" do
              config.spec_language(:pt)
              config.language.should == "pt"
            end

            it "should set the espanish language" do
              config.spec_language(:es)
              config.language.should == "es"
            end

          end
          
        end
      end
          
    end
  end
end

context "a warning" do
  
  before(:each) do
    @en_au = SpecI18n::Parser::NaturalLanguage.get("en-au")
    @en_au.stub!(:incomplete?).and_return(true)
    SpecI18n.stub!(:natural_language).and_return(@en_au)          
  end
  
  it "should show for the incomplete language" do
    message = "\n Language Warning: Incomplete Keywords For The Language 'en-au' \n"
    Kernel.should_receive(:warn).with(message)
    Spec::Runner::Configuration.new.spec_language("en-au")
  end
end

describe "load language" do
  before(:each) do
    @pt = SpecI18n::Parser::NaturalLanguage.get("pt")
    @config = ::Spec::Runner::Configuration.new
    SpecI18n.stub!(:natural_language).and_return(@pt)
  end
  it "should load all the modules" do
    Spec::DSL::Main.should_receive(:register_adverbs)
    Kernel.should_receive(:register_expectations_keywords)
    Spec::Example::ExampleGroupMethods.should_receive(:register_example_adverbs)
    Spec::Example::BeforeAndAfterHooks.should_receive(:register_hooks)
    Spec::Matchers.should_receive(:register_all_matchers)
    Spec::Example::Subject::ExampleGroupMethods.should_receive(:register_subjects)
    Spec::Example::Subject::ExampleMethods.should_receive(:register_subjects)
    @config.load_language
  end
end