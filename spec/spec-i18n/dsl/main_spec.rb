require 'spec_helper'
include Spec::DSL

describe Main do
  
  before(:each) do
    @languages = ["en", "pt", "es"]
  end

  describe 'the manipulation of methods of the domain specific language' do
    
      it "should have the methods of the dsl keywords of the language specified" do
        @languages.each do |language|
          Spec::Runner.configuration.spec_language(language)
          Main.register_adverbs
          dsl_keywords = SpecI18n::Parser::NaturalLanguage.get(language).dsl_keywords.keys
          dsl_keywords.each do |keyword|
            Main.methods.should be_include(keyword)
          end
        end
      end
  end

end