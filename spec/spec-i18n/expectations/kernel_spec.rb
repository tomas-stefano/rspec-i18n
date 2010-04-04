require 'spec_helper'

describe Object, "#should and #should_not" do
    
  before(:each) do
    @pt = SpecI18n::Parser::NaturalLanguage.get("pt")
    @es = SpecI18n::Parser::NaturalLanguage.get("es")
    @languages = {"pt" => @pt,"es" => @es}
    @pt_keywords = {"should" => "deve", "should_not" => "nao_deve"}
    @es_keywords = {"should" => "debe", "should_not" => "no_debe"}
    @pt.stub!(:keywords).and_return(@pt_keywords)
    @es.stub!(:keywords).and_return(@es_keywords)
  end

  it "should have the 'should' and 'should_not' methods translated" do
    @languages.each do |lang, language|
      SpecI18n.stub!(:natural_language).and_return(language)
      Kernel.register_expectations_keywords
      language.expectation_keywords.values.to_a.flatten.each do |keyword|
        Kernel.methods.all_to_symbols.should include(keyword.to_sym)
      end
    end
  end
  
end
