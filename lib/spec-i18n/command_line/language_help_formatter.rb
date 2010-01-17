require 'term/ansicolor'
require 'terminal-table/import'
require 'spec-i18n/parser'
  
module SpecI18n
  module CommandLine
    class LanguageHelpFormatter
      
      class << self
        include SpecI18n::Parser
        include Term::ANSIColor
        
        String.class_eval do
          include Term::ANSIColor
        end
        
        # Cucumber print table is loading 
        # because I don't want reiventing the wheel
        #
        def list_languages_and_exit(io)
          languages = list_languages
          
          languages_table = table do
            self.headings = ['Language', 'Name', 'Native']
            languages.each do |language|
              add_row language
            end
          end
          
          print_table io, languages_table, :exit => true
        end
        
        def list_keywords_and_exit(io, lang)
          
          language = NaturalLanguage.get(lang)
          
          keywords = list_basic_keywords(language)
          
          print_table io, table(nil, *keywords)
          
          advanced_keywords = list_advanced_keywords(io, language)
          
          print_table io, advanced_keywords, :exit => true
        end
        
        def list_languages
          languages = SpecI18n::SPEC_LANGUAGES.keys.sort.map do |lang|
            [ lang, grep_value(lang, 'name'), grep_value(lang, 'native') ]
          end
        end
        
        def grep_value(lang, key)
          SpecI18n::SPEC_LANGUAGES[lang][key]
        end
        
        def list_basic_keywords(language)
          NaturalLanguage::BASIC_KEYWORDS.map do |keyword|
            words = language.keywords[keyword]            
            [ keyword, words.split('|').join(' / ')] 
          end
        end
        
        def list_advanced_keywords(io, language)
          NaturalLanguage::ADVANCED_KEYWORDS.map do |keyword|
            language_keywords = [keyword]
            language.keywords[keyword].map do |key, values|
              language_keywords << [key, values.to_s.split('|').join(' / ')]
            end
            
            keywords_table = table do
              self.headings = [language_keywords.shift]
              language_keywords.each do |keywords|
                add_row keywords
              end
            end
            
            keywords_table
            
          end
        end
        
        def print_table(io, raw, options={})
          io.puts raw.to_s.send(options[:color] || :green).bold
          Kernel.exit(0) if options[:exit]
        end
      end
      
    end
  end
end