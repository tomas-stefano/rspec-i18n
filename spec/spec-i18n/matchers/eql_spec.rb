require 'spec_helper'

module Spec
  module Matchers
    describe "eql" do
      
      before(:each) do
        include SpecI18n
        @pt = Parser::NaturalLanguage.get("pt")
        Spec::Runner.configuration.spec_language("pt")
        Spec::Matchers.register_eql_matcher
      end
      
      it "should have eql matchers translated" do
        eql_word = @pt.keywords['matchers']['eql']
        1.methods.should be_include(eql_word)
      end
      
      it "should have eql? matchers translated" do
        eql_word = @pt.keywords['matchers']['eql'] + '?'        
        1.methods.should be_include(eql_word)
      end
    end
  end
end