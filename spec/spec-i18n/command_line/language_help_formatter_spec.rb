# coding: UTF-8
require 'spec_helper'

module SpecI18n
  module CommandLine
    describe Language do
      
      before(:all) do
        @es = SpecI18n::Parser::NaturalLanguage.new('es')
        @pt = SpecI18n::Parser::NaturalLanguage.new('pt')
        @io_stream = StringIO.new
      end
      
      it "should list languages" do
        Language.should_receive(:list_languages).and_return([{'name' => 'pt'}])
        Kernel.should_receive(:exit)
        Language.list_languages_and_exit(StringIO.new)
      end
      
      it "should list keywords" do
        Language.should_receive(:list_keywords).and_return(@portuguese)
        Kernel.should_receive(:exit)
        Language.list_keywords_and_exit(@io_stream, 'pt')
      end
      
      it "should list all keywords and exit" do
        Kernel.should_receive(:exit)
        Language.list_keywords_and_exit(@io_stream, 'es')
      end
    
      context "list languages" do
      
        before(:each) do
          @portuguese = { 'pt' => { 'name' => 'Portuguese', 'native' => 'Português'} }
          @spanish = { 'es' => { 'name' => 'Spanish', 'native' => 'Español' } }
        end
      
        it "should return the three keywords language for portuguese" do
          Language.should_receive(:all_languages).and_return(@portuguese)
          Language.list_languages.should eql [['pt', 'Portuguese', 'Português']]
        end
      
        it "should return the three keywords for spanish" do
          Language.should_receive(:all_languages).and_return(@spanish)
          Language.list_languages.should eql [["es", "Spanish", "Español"]]
        end
      
        it "should return the three keywords for spanish and portuguese" do
          Language.should_receive(:all_languages).and_return(@portuguese.merge(@spanish))
          Language.list_languages.should eql [["es", "Spanish", "Español"], ['pt', 'Portuguese', 'Português']]
        end
      end
    
    end
  end
end