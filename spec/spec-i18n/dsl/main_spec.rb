require 'spec_helper'
include Spec::DSL

describe Main do
  
  before(:each) do
    @pt = SpecI18n::Parser::NaturalLanguage.get("pt")
    @es = SpecI18n::Parser::NaturalLanguage.get("es")
    @languages = {"pt" => @pt,"es" => @es}
  end

  describe 'the manipulation of methods of the domain specific language' do
    before(:each) do
      @pt_keywords = {"describe" => "descreva|contexto"}
      @es_keywords = {"describe" => "descreba|describir"}
      @pt.stub!(:keywords).and_return(@pt_keywords)
      @es.stub!(:keywords).and_return(@es_keywords)
    end
    
    it "should have the methods of the dsl keywords of the language specified" do
      mock_natural_language(@pt)
      Main.register_adverbs
      [:descreva, :contexto].each do |keyword|
        Main.methods.all_to_symbols.should include(keyword)
      end
    end    
    
    it "should have the method for other language" do
      mock_natural_language(@es)
      Main.register_adverbs
      [:descreba, :describir].each do |keyword|
        Main.methods.all_to_symbols.should include(keyword)
      end
    end    
    
  end

  describe "the manipulation of shared examples for"  do
    
    before(:each) do
      @pt_keywords = { "shared_examples_for" => "exemplos_distribuidos|exemplos_distribuidos_para" } 
      @pt.stub!(:keywords).and_return(@pt_keywords)
    end
    
    it "should register all the keywords for the shared examples for" do
      mock_natural_language(@pt)
      Main.translate_shared_examples_for
      [:exemplos_distribuidos, :exemplos_distribuidos_para].each do |keyword|
        Main.methods.all_to_symbols.should include(keyword)
      end
    end
    
  end

end
