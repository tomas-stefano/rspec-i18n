require 'spec_helper'

module RspecI18n
  module Parser
    describe NaturalLanguage do

      before(:each) do
        @pt = NaturalLanguage.get('pt')
      end

      it "should raise for the non existing language" do
        lambda {  NaturalLanguage.new('en') }.should raise_error()
      end

      %w(describe before after it should).each do |keyword|
        it "should have the #{keyword} keyword" do
          @pt.keywords.should be_include(keyword)
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
          lambda {@pt.spec_keywords("no_found")}.should raise_error(RuntimeError)
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
