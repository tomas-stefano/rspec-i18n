require "spec_helper"

describe SpecI18n do
    
  it "should assign the spec language constant" do
    languages = ["pt", "es"]
    languages.each do |language|
      Spec::Runner.configuration.spec_language(language)
      spec_language.should == language
    end
  end
  
  it "should assign the natural language" do
    language = 'pt'
    Spec::Runner.configuration.spec_language(language)
    natural_language.keywords.should == Parser::NaturalLanguage.get(spec_language).keywords
  end
end