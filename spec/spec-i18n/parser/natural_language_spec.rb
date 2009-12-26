require 'spec_helper'

module SpecI18n
  module Parser
    describe NaturalLanguage do

      before(:each) do
        @pt = NaturalLanguage.get('pt')
      end

      context "get languages" do
        
        it "should get the default language" do
          NaturalLanguage.get("en").should_not be_nil
        end
        
        it "should raise for the non existing language" do
          language = "non_existing"
          lambda {  
            NaturalLanguage.new(language) 
          }.should raise_error(LanguageNotFound, "Language #{language} Not Supported")
        end

      end

      %w(describe before after it should).each do |keyword|
        it "should have the #{keyword} keyword" do
          
        end
      end

      context "of dsl keywords" do
      
        it "should return all the dsl keywords" do
          @pt.dsl_keywords.should == ["descreva", "contexto"]
        end

        it "should return the describe dsl keyword" do
          lang = { "describe" => "descreva", :before => "antes" }
          @pt.should_receive(:keywords).and_return(lang)
          @pt.dsl_keywords.should == [lang["describe"]]
        end
      end

      context "of expectations keywords" do
        it "should return the should expectations keywords" do
          @pt.expectation_keywords.should == ["deve"]
        end

        it "should return the expectation keyword" do
          lang = {"describe" => "descreva", "should" => "deve"}
          @pt.should_receive(:keywords).and_return(lang)
          @pt.expectation_keywords.should == [lang["should"]]
        end
      end

      context "of all matchers" do
        it "should parse all matchers"
      end

      context "splitting the keys" do
        it "should raise no found key" do
          lambda {
            @pt.spec_keywords("no_found")
          }.should raise_error(RuntimeError)
        end

        it "should split correctly the keys" do
         lang = { "describe" => "descreva|contexto" }
         NaturalLanguage.instance_variable_set(:@keywords, lang["describe"])
         @pt.spec_keywords("describe").should == ["descreva", "contexto"]
        end
      end
    end
  end
end
