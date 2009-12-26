require 'spec_helper'

module Spec
  module Example
    describe BeforeAndAfterHooks do
      
      before(:each) do
        @languages = ["pt", "en", "es"]
      end
      
      it "should include all i18n methods to Before and After Hooks" do
        @languages.each do |language|
          Spec::Runner.configuration.spec_language(language)
          language = SpecI18n::Parser::NaturalLanguage.get(language)
          language.before_and_after_keywords.keys.map do |keyword|
            BeforeAndAfterHooks.methods.should be_include(keyword)
          end
        end
      end
        
      it "should translate the hooks parameters and parse options" do
        @languages.each do |language|
          Spec::Runner.configuration.spec_language(language)
          language = SpecI18n::Parser::NaturalLanguage.get(language)
          Spec::Example::BeforeAndAfterHooks.should_receive(:before_each_parts)
          before_parts(:each, 't')
        end
      end
          
    end
  end
end
