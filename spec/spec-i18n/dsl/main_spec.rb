require 'spec_helper'
include Spec::DSL

describe Main do
  
  before(:each) do
    @pt = SpecI18n::Parser::NaturalLanguage.get("pt")
    @es = SpecI18n::Parser::NaturalLanguage.get("es")
    @languages = {"pt" => @pt,"es" => @es}
    @pt_keywords = {"describe" => "descreva"}
    @es_keywords = {"describe" => "descreva"}
    @pt.stub!(:keywords).and_return(@pt_keywords)
    @es.stub!(:keywords).and_return(@es_keywords)
  end

  describe 'the manipulation of methods of the domain specific language' do
    
      it "should have the methods of the dsl keywords of the language specified" do
        @languages.each do |lang, language|
          SpecI18n.stub!(:natural_language).and_return(language)
          Spec::DSL::Main.register_adverbs
          language.dsl_keywords.values.flatten.each do |keyword|
            Main.methods.all_to_symbols.should include(keyword.to_sym)
          end
        end
      end
  end

end
