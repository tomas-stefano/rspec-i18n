# coding: UTF-8
require 'spec_helper'

module SpecI18n
  module CommandLine
    describe LanguageHelpFormatter do
      
      before(:all) do
        @es = SpecI18n::Parser::NaturalLanguage.new('es')
        @pt = SpecI18n::Parser::NaturalLanguage.new('pt')
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
      
      it "should list all keywords and exit" do
        Kernel.should_receive(:exit)
        LanguageHelpFormatter.list_keywords_and_exit(@io_stream, 'es')
      end
    
      context "list languages" do
      
        before(:each) do
          @portuguese = { 'pt' => { 'name' => 'Portuguese', 'native' => 'Português'} }
          @spanish = { 'es' => { 'name' => 'Spanish', 'native' => 'Español' } }
        end
      
        it "should return the three keywords language for portuguese" do
          LanguageHelpFormatter.should_receive(:all_languages).and_return(@portuguese)
          LanguageHelpFormatter.list_languages.should eql [['pt', 'Portuguese', 'Português']]
        end
      
        it "should return the three keywords for spanish" do
          LanguageHelpFormatter.should_receive(:all_languages).and_return(@spanish)
          LanguageHelpFormatter.list_languages.should eql [["es", "Spanish", "Español"]]
        end
      
        it "should return the three keywords for spanish and portuguese" do
          LanguageHelpFormatter.should_receive(:all_languages).and_return(@portuguese.merge(@spanish))
          LanguageHelpFormatter.list_languages.should eql [["es", "Spanish", "Español"], ['pt', 'Portuguese', 'Português']]
        end
      end
    
      context "list all keywords" do
      
        before(:each) do
          @portuguese_keywords = { 'name' => 'Portuguese', 'native' => 'Português'}
        end
        
        it "should return blank keywords" do
          @pt.should_receive(:keywords).at_least(:once).and_return(@portuguese_keywords)
          esperado = [["name", "Portuguese"], ["native", "Português"], ["describe", ""], ["before", ""], ["after", ""], ["it", ""], ["pending", ""], ["subject", ""], ["its", ""], ["should", ""], ["should_not", ""]]
          LanguageHelpFormatter.list_basic_keywords(@pt).should == esperado
        end
        
        context 'when values from keywords' do
          
          before(:each) do
            @blank_keywords = { 'name' => 'Portuguese'}
            @keywords = { 'hooks' => { 'all' => 'todos', 'each' => 'cada'}}
          end
          
          it "should return the hooks keywords for list" do
            @pt.should_receive(:keywords).at_least(:once).and_return(@keywords)
            LanguageHelpFormatter.values_from_keywords(@pt, 'hooks').should eql(@keywords['hooks'])
          end
          
          it "should return a Hash with key and empty value" do
            @pt.should_receive(:keywords).at_least(:once).and_return(@blank_keywords)
            LanguageHelpFormatter.values_from_keywords(@pt, 'matchers').should eql({})
          end
          
        end
                    
        describe 'the advanced keywords' do
        
          before(:each) do
            @io = StringIO.new
            @blank_keywords = { 'name' => 'Spanish', 'native' => 'Español'}
          end
        
          it "should return empty hooks for empty keywords" do
            @es.should_receive(:keywords).at_least(:once).and_return(@blank_keywords)
            LanguageHelpFormatter.list_advanced_keywords(@io, @es).first.headings.should == ['hooks']
          end
          
          it "should return a empty matcher for empty keywords" do
            @es.should_receive(:keywords).at_least(:once).and_return(@blank_keywords)
            LanguageHelpFormatter.list_advanced_keywords(@io, @es).last.headings.should == ['matchers']
          end

        end
      
      end
    
    end
  end
end