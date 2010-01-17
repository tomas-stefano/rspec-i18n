require 'spec_helper'

module SpecI18n
  module CommandLine
    describe LanguageHelpFormatter do
      
      before(:all) do
        @pt = SpecI18n::Parser::NaturalLanguage.get('pt')
        @languages = LanguageHelpFormatter.list_languages
        @portuguese = LanguageHelpFormatter.list_basic_keywords(@pt)
        @io_stream = StringIO.new
      end
      
      it "should list languages" do
        LanguageHelpFormatter.should_receive(:list_languages).and_return(@languages)
        Kernel.should_receive(:exit)
        LanguageHelpFormatter.list_languages_and_exit(StringIO.new)
      end
      
      it "should list keywords" do
        LanguageHelpFormatter.should_receive(:list_basic_keywords).and_return(@portuguese)
        Kernel.should_receive(:exit)
        LanguageHelpFormatter.list_keywords_and_exit(@io_stream, 'pt')
      end
    
      context "list languages" do
      
        before(:each) do
          @portuguese = ["pt", "Portuguese", "português"]
          @spanish = ["es", "Spanish", "español"]
        end
      
        it "should return the three keywords language for portuguese" do
          SpecI18n::SPEC_LANGUAGES.should_receive(:keys).and_return("pt")
          LanguageHelpFormatter.list_languages.should == [@portuguese]
        end
      
        it "should return the three keywords for spanish" do
          SpecI18n::SPEC_LANGUAGES.should_receive(:keys).and_return("es")
          LanguageHelpFormatter.list_languages.should == [@spanish]
        end
      
        it "should return the three keywords for spanish and portuguese" do
          SpecI18n::SPEC_LANGUAGES.should_receive(:keys).and_return(["pt", "es"])
          LanguageHelpFormatter.list_languages.should == [@portuguese, @spanish].sort
        end
      end
    
      context "list all keywords" do
      
        before(:each) do
          @language_keywords = LanguageHelpFormatter.list_basic_keywords(@pt)
        end
      
        # TODO: It's 3 a.m in the morning ... Ugly Specs ... #FIXME
      
        it "should return all basic keywords for a language" do
          words = %w(name native describe before after it should should_not)
          words.each do |word|
            @language_keywords.flatten.should include(word)
          end
        end
      
        it "should return the example keyword for the portuguese language" do
          example = @language_keywords.map { |array| array if array.include?("it") }.compact.flatten
          example.should == ["it", "exemplo / especificar"]
        end
      
        describe 'the advanced keywords' do
        
          before(:each) do
            @language_keywords = LanguageHelpFormatter.list_advanced_keywords(StringIO.new, 'pt')
          end
        
          it "should return the matchers keywords for language" do
            @language_keywords.flatten.should include('matchers')
          end

          it "should return the hooks keywords for language" do
            @language_keywords.flatten.should include('hooks')
          end
        end
      
      end
    
    end
  end
end