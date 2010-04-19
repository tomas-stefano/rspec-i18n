require 'term/ansicolor'
require 'terminal-table/import'
require 'spec-i18n/spec_language'
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
        
        # List all languages available in the languages.yml
        #
        def list_languages
          languages = all_languages.keys.sort.collect do |lang|
            [ lang, grep_value(lang, 'name'), grep_value(lang, 'native') ]
          end
        end
        
        # Grep the value 
        def grep_value(lang, key)
          SpecI18n::SPEC_LANGUAGES[lang][key]
        end
        
        def list_basic_keywords(language)
          NaturalLanguage::BASIC_KEYWORDS.collect do |keyword|
            words = language.keywords[keyword].to_s.split('|').join(' / ')
            [ keyword, words ] 
          end
        end
        
        def list_advanced_keywords(io, language)
          NaturalLanguage::ADVANCED_KEYWORDS.collect do |keyword|
            language_keywords = [keyword]
                        
            values = values_from_keywords(language, keyword)
            
            values.keys.sort.collect do |key|
              language_keywords << [key, values[key].to_s.split('|').join(' / ')]
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
        
        # Return the values from keywords
        #
        # values_from_keywords(@portuguese, 'hooks') # => {'all'=>'todos','each'=>'cada'}
        #
        def values_from_keywords(language, keyword)
          unless language.keywords[keyword]
            {}
          else
            language.keywords[keyword]
          end
        end
        
        def print_table(io, raw, options={})
          begin
            io.puts raw.to_s.send(options[:color] || :green).bold
          rescue Terminal::Table::Error
            io.puts("Empty Keywords(hooks or matchers) - See http://github.com/tomas-stefano/rspec-i18n/blob/master/lib/spec-i18n/languages.yml file")
            io.puts
          end
          Kernel.exit(0) if options[:exit]
        end
      end
      
    end
  end
end
