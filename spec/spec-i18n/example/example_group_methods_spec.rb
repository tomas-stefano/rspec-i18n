require "spec_helper"

module Spec
  module Example
    describe ExampleGroupMethods do
      
      before(:each) do
        @languages = ["pt", "es", "en"]
      end
      
      it "should include #it example translated methods" do
        @languages.each do |language|
          Spec::Runner.configuration.spec_language(language)
          language = SpecI18n::Parser::NaturalLanguage.get(language)
          language.example_group_keywords.values.flatten.each do |keyword|
            pending "I don't know wich module is included the keywords (Is 2:43 AM - I'll relaxing in my couch)"
          end
        end
      end
    end
  end
end