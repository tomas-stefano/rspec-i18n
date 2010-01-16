require 'spec_helper'

module SpecI18n
  module CommandLine
    describe LanguageHelpFormatter do
      
      before(:all) do
        @languages = SpecI18n::Parser::NaturalLanguage.list_languages
        @portuguese = SpecI18n::Parser::NaturalLanguage.list_basic_keywords("pt")
        @io_stream = StringIO.new
      end
      
      it "should list languages" do
        SpecI18n::Parser::NaturalLanguage.should_receive(:list_languages).and_return(@languages)
        Kernel.should_receive(:exit)
        LanguageHelpFormatter.list_languages_and_exit(StringIO.new)
      end
      
      it "should list keywords" do
        SpecI18n::Parser::NaturalLanguage.should_receive(:list_basic_keywords).and_return(@portuguese)
        Kernel.should_receive(:exit)
        LanguageHelpFormatter.list_keywords_and_exit(@io_stream, 'pt')
      end
    end
  end
end