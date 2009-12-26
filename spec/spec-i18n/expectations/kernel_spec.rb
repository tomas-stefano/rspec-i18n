require 'spec_helper'

describe Object, "#should" do
  
  before(:each) do
    @languages = ["pt", "en", "es"]
  end

  it "should have the 'should' and 'should_not' methods translated" do
    @languages.each do |language|
      Spec::Runner.configuration.spec_language(language)
      Kernel.register_expectations_keywords
      language = SpecI18n::Parser::NaturalLanguage.get(language)
      language.expectation_keywords.keys.each do |keyword|
        Kernel.methods.should be_include(keyword)
      end
    end
  end
end
